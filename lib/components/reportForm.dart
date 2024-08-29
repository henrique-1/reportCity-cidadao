import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final GlobalKey _reportFormKey = GlobalKey<FormState>();
  final TextEditingController _reportTitleController = TextEditingController();
  final TextEditingController _reportDescriptionController =
      TextEditingController();
  var geolocation;
  var picturePath;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _reportTitleController.dispose();
    _reportDescriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDCDCDA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          child: RefreshIndicator(
            onRefresh: () => Future.delayed(
              const Duration(seconds: 1),
            ),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: size.width * 0.65,
                            child: newReportText(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {},
                          child: picturePath == null
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      picturePath = Navigator.pushNamed(
                                          context, "/cameraReport");
                                    });
                                    print("Foto: $picturePath");
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        16.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF494845)
                                              .withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      color: const Color(0xFF262624),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Color(
                                          0xFFf6f6f6,
                                        ),
                                        size: 72,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Expanded(
                        flex: 2,
                        child: Form(
                          key: _reportFormKey,
                          child: Column(
                            children: [
                              reportTitleTextField(size),
                              SizedBox(
                                height: 8.h,
                              ),
                              reportDescriptionTextField(size),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      newReportButton(size),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 335.h
                            : 0.h,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newReportText() {
    return Center(
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.inter(
            fontSize: 28.0.sp,
            color: const Color(0xFF122115),
            height: 1.45.h,
          ),
          children: const [
            TextSpan(text: "Realizar nova"),
            TextSpan(
              text: " ",
            ),
            TextSpan(
              text: "Denuncia",
              style: TextStyle(
                color: Color(0xFF122115),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reportTitleTextField(Size size) {
    return TextFormField(
      controller: _reportTitleController,
      maxLines: 1,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        return value!.isEmpty ? "Insira o título da denuncia!" : null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Título",
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          color: const Color(0xFF8b8a84),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF3A6642),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF3A6642),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFbc6262),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFbc6262),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget reportDescriptionTextField(Size size) {
    return TextFormField(
      controller: _reportDescriptionController,
      maxLines: 6,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF3A6642),
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Descrição",
        alignLabelWithHint: true,
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          color: const Color(0xFF8b8a84),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF3A6642),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF3A6642),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFbc6262),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFbc6262),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget newReportButton(Size size) {
    return ElevatedButton(
      onPressed: () async {
        print("tab");
        geolocation = await determinePosition();
        Navigator.popAndPushNamed(context, "/home");
      },
      style: ButtonStyle(
        alignment: Alignment.center,
        fixedSize: WidgetStatePropertyAll(
          Size(size.width, 50.h),
        ),
        backgroundColor: const WidgetStatePropertyAll(
          Color(0xFF3a6642),
        ),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFFa6cfad).withOpacity(0.2),
        ),
      ),
      child: Text(
        "Realizar denuncia",
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xFFf6f6f6),
          fontWeight: FontWeight.w600,
          height: 1.5.h,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
