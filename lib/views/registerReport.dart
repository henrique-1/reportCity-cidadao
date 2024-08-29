import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterReport extends StatefulWidget {
  const RegisterReport({super.key});

  @override
  State<RegisterReport> createState() => _RegisterReportState();
}

class _RegisterReportState extends State<RegisterReport>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  final resolutionPresets = ResolutionPreset.values;
  FlashMode? _currentFlashMode;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / controller!.value.aspectRatio,
                  child: controller!.buildPreview(),
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DropdownButton<ResolutionPreset>(
                                dropdownColor: Colors.black87,
                                underline: Container(),
                                value: currentResolutionPreset,
                                items: [
                                  for (ResolutionPreset preset
                                      in resolutionPresets)
                                    DropdownMenuItem(
                                      value: preset,
                                      child: Text(
                                        preset
                                            .toString()
                                            .split('.')[1]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    currentResolutionPreset = value!;
                                    _isCameraInitialized = false;
                                  });
                                  onNewCameraSelected(controller!.description);
                                },
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              XFile? rawImage = await takePicture();

                              File imageFile = File(rawImage!.path);

                              int currentUnix =
                                  DateTime.now().millisecondsSinceEpoch;
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              String fileFormat =
                                  imageFile.path.split('.').last;

                              await imageFile.copy(
                                '${directory.path}/$currentUnix.$fileFormat',
                              );

                              Navigator.pop(context, rawImage);
                            },
                            child: const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.white38, size: 80),
                                Icon(Icons.circle,
                                    color: Colors.white, size: 65),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container(),
    );
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }
}
