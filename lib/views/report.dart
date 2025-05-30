import 'dart:convert';
import 'dart:io';
import 'package:cidadao/components/elevatedButton.dart';
import 'package:cidadao/components/textFormField.dart';
import 'package:cidadao/functions/retreive_cache.dart';
import 'package:cidadao/main.dart';
import 'package:cidadao/config/app_config.dart'; // Import AppConfig
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class ReportType {
  final String type;

  ReportType({required this.type});
}

List<ReportType> reportsType = [
  ReportType(type: "BURACO NA VIA"),
  ReportType(type: "BURACO NA CALÇADA"),
  ReportType(type: "POSTE DANIFICADO"),
  ReportType(type: "ÁRVORE CAÍDA"),
  ReportType(type: "REDE ELÉTRICA DANIFICADA"),
];

class _ReportState extends State<Report> {
  final _reportFormKey = GlobalKey<FormState>();
  ReportType? _selectedType;
  bool _isSubmitting = false; // For loading state

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  var geolocation;
  File? _reportImage;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // ReportType? selectedType; // Removed from build method
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEFEFEF), // TODO: Use themed color
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w,
          ),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 24.0.sp,
                          color: const Color(0xFF262624),
                          height: 1.16.h,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Realizar uma',
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'Denúncia',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final imagePicked =
                            await Navigator.pushNamed(context, "/report_image");
                        print(imagePicked);
                        if (imagePicked is File) {
                          setState(() {
                            _reportImage = File(imagePicked.path);
                          });
                        }
                      },
                      child: _reportImage == null
                          ? Container(
                              height: 351.h,
                              width: 254.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3.r,
                                    color: Colors.black,
                                    spreadRadius: 0.5.r,
                                    blurStyle: BlurStyle.solid,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 75.sp,
                                ),
                              ),
                            )
                          // : Container(),
                          : Image.file(
                              _reportImage!,
                              height: 351.h,
                              width: 254.w,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Form(
                     key: _reportFormKey, // Assign the GlobalKey to the Form
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        DropdownMenu<ReportType>(
                          initialSelection: _selectedType ?? reportsType[0], // Use state variable
                          dropdownMenuEntries: [
                            for (var tipos in reportsType)
                              DropdownMenuEntry(label: tipos.type, value: tipos)
                          ],
                          width: screenSize.width,
                          onSelected: (ReportType? type) {
                            setState(() {
                              _selectedType = type; // Update state variable
                            });
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          textFormFieldController: _titleController,
                          formKey: _reportFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira o título da denúncia";
                            }

                            return null;
                          },
                          label: "Título",
                          maxLines: 1,
                          textInputType: TextInputType.text,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(64)
                          ],
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                          isEnabled: true,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          textFormFieldController: _descriptionController,
                          formKey: _reportFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira a descrição da denúncia. Forneça mais informações sobre o problema que está sendo reportado.";
                            }

                            return null;
                          },
                          label: "Descrição",
                          maxLines: 4,
                          textInputType: TextInputType.text,
                          isObscure: false,
                          textInputAction: TextInputAction.done,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(255)
                          ],
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                          isEnabled: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButtonWidget(
                    callback: () async {
                      if (!_reportFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha os campos obrigatórios e selecione uma imagem.',
                            ),
                          ),
                        );
                        return;
                      }

                      if (_reportImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, adicione uma imagem para a denúncia.'),
                          ),
                        );
                        return;
                      }

                      if (_selectedType == null) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, selecione um tipo de denúncia.'),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        _isSubmitting = true;
                      });

                      dynamic currentGeolocation;
                      double? latitude;
                      double? longitude;

                      try {
                        // TODO: Replace determinePosition() with a robust solution that includes timeouts, error handling, and permission checks.
                        // Assuming determinePosition() might throw an error or return a specific value for failure.
                        currentGeolocation = await determinePosition();

                        if (currentGeolocation == null) {
                           throw Exception("Não foi possível obter a localização.");
                        }
                        // Example check, adjust based on how determinePosition signals error/no location
                        if (currentGeolocation.latitude == 0.0 && currentGeolocation.longitude == 0.0) {
                          throw Exception("Localização inválida recebida. Verifique os serviços de localização.");
                        }
                        latitude = currentGeolocation.latitude;
                        longitude = currentGeolocation.longitude;

                        Uint8List bytes = await _reportImage!.readAsBytes();
                        String base64String = base64Encode(bytes);

                        // TODO: Securely fetch publicId and API token. getData might need to be async.
                        final publicId = getData('public_id');
                        // final apiToken = await retrieveToken(); // Placeholder for token retrieval

                        if (publicId == null) {
                          throw Exception("Usuário não identificado. Faça login novamente.");
                        }

                        // TODO: Securely fetch API token. This should be an async call.
                        // final String? apiToken = await retrieveData('token');
                        final String? apiToken = getData('token'); // Assuming synchronous for now, like publicId

                        if (apiToken == null) {
                          throw Exception("Token de autenticação não encontrado. Faça login novamente.");
                        }

                        Response<dynamic> response = await Dio().post(
                          "${AppConfig.apiUrl}/cliente/denuncia/$publicId", // Use AppConfig
                          data: {
                            'latitude': latitude,
                            'longitude': longitude,
                            // TODO: Confirm with backend if key is 'imageBase64' or 'imagemBase64'
                            'imageBase64': base64String,
                            'titulo': _titleController.text,
                            'descricao': _descriptionController.text,
                            'tipo': _selectedType!.type
                          },
                          options: Options(
                            responseType: ResponseType.json,
                            headers: {'Authorization': 'Bearer $apiToken'}, // Add API Token
                          ),
                        );

                        if (response.statusCode == 200 || response.statusCode == 201) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Denúncia enviada com sucesso!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.popAndPushNamed(context, "/home");
                          }
                        } else {
                          throw DioException(
                            requestOptions: response.requestOptions,
                            response: response,
                            message: "Erro ao enviar denúncia: ${response.statusMessage}"
                          );
                        }
                      } on DioException catch (e) {
                        debugPrint("DioException during report submission: ${e.message}");
                        debugPrint("Response data: ${e.response?.data}");
                        if (mounted) {
                          String errorMessage = "Erro de rede ao enviar denúncia.";
                           if (e.response?.data is Map && e.response?.data['message'] != null) {
                            errorMessage = "Erro: ${e.response!.data['message']}";
                          } else if (e.response?.statusCode == 401) {
                            errorMessage = "Autenticação falhou. Faça login novamente.";
                          } else if (e.message != null && e.message!.isNotEmpty) {
                            errorMessage = e.message!;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (err) {
                        debugPrint("Unexpected error during report submission: $err");
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ocorreu um erro inesperado: ${err.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isSubmitting = false;
                          });
                        }
                      }
                    },
                    width_: screenSize.width,
                    height_: 50.h,
                    label: _isSubmitting ? "Enviando..." : "Enviar Denúncia",
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
