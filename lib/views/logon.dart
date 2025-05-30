import 'dart:io';

import 'package:cidadao/components/password_validator.dart';
import 'package:cidadao/functions/image_to_base64.dart';
import 'package:cidadao/functions/save_cache.dart';
// import 'package:dio/io.dart'; // Unused import
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:cidadao/config/app_config.dart'; // Import AppConfig
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cidadao/components/elevatedButton.dart';
import 'package:cidadao/components/imageAsset.dart';
import 'package:cidadao/components/textFormField.dart';

class Logon extends StatefulWidget {
  const Logon({super.key});

  @override
  State<Logon> createState() => _LogonState();
}

class _LogonState extends State<Logon> {
  final _logonFormKey = GlobalKey<FormState>();
  final GlobalKey<FlutterPwValidatorState> _passwordValidatorKey =
      GlobalKey<FlutterPwValidatorState>();
  bool _isLoading = false; // Loading state for registration button

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _fullNameController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _zipController.dispose();
    _streetController.dispose();
    _houseNumberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> getZipCodeInfo(String normalizedZipCode) async {
    try {
      // Ensure AppConfig.viaCepApiUrl is defined, e.g., static const String viaCepApiUrl = 'https://viacep.com.br/ws';
      Response<dynamic> response = await Dio().get(
        "${AppConfig.viaCepApiUrl}/$normalizedZipCode/json/",
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      // ViaCEP returns 200 even for non-existent CEPs, with an "erro" flag
      if (response.data is Map && response.data['erro'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CEP não encontrado.')),
          );
        }
        _clearAddressFields(); // Clear fields if CEP is not found
        return;
      }

      if (response.data != null && response.data['logradouro'] != null) {
        _streetController.text = response.data['logradouro'];
        _neighborhoodController.text = response.data['bairro'];
        _cityController.text = response.data['localidade'];
        _stateController.text = response.data['uf'];
        // TODO: Reconsider validating the entire form here. It might be better to let individual fields handle their validation state.
        if (mounted) {
           _logonFormKey.currentState?.validate();
        }
      } else {
         // This case might be redundant if 'erro:true' check is robust
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resposta inválida do serviço de CEP.')),
          );
        }
        _clearAddressFields();
      }
    } on DioException catch (e) {
      debugPrint("DioException in getZipCodeInfo: ${e.message}");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar CEP: ${e.message}')),
        );
      }
      _clearAddressFields();
    } catch (err) {
      debugPrint("Unexpected error in getZipCodeInfo: $err");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ocorreu um erro inesperado ao buscar informações do CEP.')),
        );
      }
      _clearAddressFields();
    }
  }

  void _clearAddressFields() {
    _streetController.clear();
    _neighborhoodController.clear();
    _cityController.clear();
    _stateController.clear();
     if (mounted) {
        _logonFormKey.currentState?.validate(); // Re-validate relevant fields after clearing
     }
  }

  /// Cadastro:
  /// - Nome Completo
  /// - CPF
  /// - Telefone celular
  /// - E-mail
  /// - CEP
  /// - Logradouro (RUA)
  /// - Numero
  /// - Complemento
  /// - Bairro
  /// - Cidade
  /// - Estado
  /// - Senha
  /// - Confirmação de Senha

  File? _reportImage;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w,
          ),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120.h,
                  ),
                  ImageAsset(
                    asset: 'assets/reportCityLogoConverted.png',
                    width_: screenSize.height / 5,
                    height_: screenSize.height / 5,
                    imageAlignment: Alignment.center,
                    hasAntiAlias: true,
                    imageFilterQuality: FilterQuality.high,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Form(
                    key: _logonFormKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () async {
                              final imagePicked = await Navigator.pushNamed(
                                  context, "/report_image");
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
                          height: 16.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _fullNameController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira seu nome completo!";
                            }
                          },
                          label: "Nome completo",
                          maxLines: 1,
                          textInputType: TextInputType.name,
                          isObscure: false,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(128)
                          ],
                          //maxLength: 128,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _cpfController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira seu CPF!";
                            }

                            if (!GetUtils.isCpf(value)) {
                              return "CPF incorreto";
                            }

                            return null;
                          },
                          label: "CPF",
                          maxLines: 1,
                          textInputType: TextInputType.number,
                          isObscure: false,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                            LengthLimitingTextInputFormatter(14)
                          ],
                          //maxLength: 14,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _phoneController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira seu celular";
                            }

                            return null;
                          },
                          label: "Celular",
                          maxLines: 1,
                          textInputType: TextInputType.number,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                            LengthLimitingTextInputFormatter(15)
                          ],
                          //maxLength: 11,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _emailController,
                          isObscure: false,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.next,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira seu e-mail!";
                            }

                            if (!EmailValidator.validate(value)) {
                              return "E-mail incorreto!";
                            }
                            return null;
                          },
                          label: "E-mail",
                          maxLines: 1,
                          textInputType: TextInputType.emailAddress,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(255)
                          ],
                          // maxLength: 255,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 3,
                              child: Divider(
                                color: Color(0xFF9e9d99),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Endereço",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color.fromARGB(255, 77, 71, 50),
                                  fontWeight: FontWeight.w500,
                                  height: 1.67.sp,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 3,
                              child: Divider(
                                color: Color(0xFF9e9d99),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _zipController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira seu CEP!";
                            }
                            return null;
                          },
                          label: "CEP",
                          maxLines: 1,
                          textInputType: TextInputType.number,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                            LengthLimitingTextInputFormatter(10)
                          ],
                          onEditComplete: () {
                            if (_zipController.text.isNotEmpty) {
                              final String normalizedZipCode =
                                  UtilBrasilFields.removeCaracteres(
                                      _zipController.text);

                              getZipCodeInfo(normalizedZipCode);
                              FocusScope.of(context).nextFocus();
                            } else {}
                          },
                          //maxLength: 8,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.65,
                              child: TextFormFieldWidget(
                                isEnabled: true,
                                textFormFieldController: _streetController,
                                formKey: _logonFormKey,
                                callback: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira a rua!";
                                  }
                                  return null;
                                },
                                label: "Rua",
                                maxLines: 1,
                                textInputType: TextInputType.streetAddress,
                                isObscure: false,
                                textInputAction: TextInputAction.next,
                                textInputFormatter: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                //maxLength: 255,
                                maxLengthEnforced:
                                    MaxLengthEnforcement.enforced,
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.3,
                              child: TextFormFieldWidget(
                                isEnabled: true,

                                textFormFieldController: _houseNumberController,
                                formKey: _logonFormKey,
                                callback: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira o número!";
                                  }
                                  return null;
                                },
                                label: "Numero",
                                maxLines: 1,
                                textInputType: TextInputType.streetAddress,
                                isObscure: false,
                                textInputAction: TextInputAction.next,
                                textInputFormatter: [
                                  LengthLimitingTextInputFormatter(6)
                                ],
                                //maxLength: 6,
                                maxLengthEnforced:
                                    MaxLengthEnforcement.enforced,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,
                          textFormFieldController: _complementController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            return null;
                          },
                          label: "Complemento",
                          maxLines: 1,
                          textInputType: TextInputType.streetAddress,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          maxLength: 16,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _neighborhoodController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira o bairro!";
                            }
                            return null;
                          },
                          label: "Bairro",
                          maxLines: 1,
                          textInputType: TextInputType.streetAddress,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(64)
                          ],
                          //maxLength: 64,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _cityController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira a cidade!";
                            }
                            return null;
                          },
                          label: "Cidade",
                          maxLines: 1,
                          textInputType: TextInputType.streetAddress,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(32)
                          ],
                          //maxLength: 32,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _stateController,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value.isEmpty) {
                              return "Insira o estado!";
                            }
                            return null;
                          },
                          label: "Estado",
                          maxLines: 1,
                          textInputType: TextInputType.streetAddress,
                          isObscure: false,
                          textInputAction: TextInputAction.next,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(32)
                          ],
                          //maxLength: 32,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 3,
                              child: Divider(
                                color: Color(0xFF9e9d99),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Senha",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color.fromARGB(255, 77, 71, 50),
                                  fontWeight: FontWeight.w500,
                                  height: 1.67.sp,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 3,
                              child: Divider(
                                color: Color(0xFF9e9d99),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _passwordController,
                          isObscure: true,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.next,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira sua senha!";
                            }

                            return null;
                          },
                          label: "Senha",
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(60)
                          ],
                          //maxLength: 60,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        PasswordValidator(
                          validatorStateKey: _passwordValidatorKey,
                          width: screenSize.width,
                          height: 150.h,
                          onSuccessCallback: () {},
                          onFailureCallback: () {},
                          passwordController: _passwordController,
                          minLength: 8,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController:
                              _passwordConfirmationController,
                          isObscure: true,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.done,
                          formKey: _logonFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira a confirmação da sua senha!";
                            }

                            if (_passwordController.text !=
                                _passwordConfirmationController.text) {
                              return "As senhas devem ser idênticas";
                            }

                            return null;
                          },
                          label: "Confirmação de senha",
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(60)
                          ],
                          // maxLength: 60,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  ElevatedButtonWidget(
                    callback: () async {
                      if (!_logonFormKey.currentState!.validate()) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Por favor, corrija os erros no formulário.')),
                          );
                        }
                        return;
                      }

                      if (_reportImage == null) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Por favor, selecione uma imagem de perfil.')),
                          );
                        }
                        return;
                      }
                       // Validate password using FlutterPwValidator's state
                      if (_passwordValidatorKey.currentState != null &&
                          !_passwordValidatorKey.currentState!.validate()) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Senha inválida. Verifique os critérios.')),
                            );
                          }
                          return;
                      }


                      setState(() {
                        _isLoading = true;
                      });

                      String? imageBase64;
                      try {
                        imageBase64 = await convertToBase64(_reportImage!);
                      } catch (e) {
                        debugPrint("Error converting image to Base64: $e");
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Erro ao processar imagem. Tente outra.')),
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                        return;
                      }

                      try {
                        // Registration Call
                        // Ensure AppConfig.apiUrl uses HTTPS if that's the standard
                        Response<dynamic> responseLogon = await Dio().post(
                          "${AppConfig.apiUrl}/cidadao", // Use AppConfig
                          data: {
                            'fullname': _fullNameController.text,
                            'cpf': UtilBrasilFields.removeCaracteres(_cpfController.text),
                            'cellphone': UtilBrasilFields.removeCaracteres(_phoneController.text),
                            'email': _emailController.text,
                            'cep': UtilBrasilFields.removeCaracteres(_zipController.text),
                            'street': _streetController.text,
                            'houseNumber': _houseNumberController.text,
                            'houseComplement': _complementController.text,
                            'district': _neighborhoodController.text,
                            'city': _cityController.text,
                            'state': _stateController.text,
                            'password': _passwordController.text,
                            'confirmPassword': _passwordConfirmationController.text,
                            'imageBase64': imageBase64,
                          },
                          options: Options(
                            responseType: ResponseType.json,
                          ),
                        );

                        if (responseLogon.statusCode == 200 || responseLogon.statusCode == 201) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cadastro realizado com sucesso! Efetuando login...'),
                                  backgroundColor: Colors.green),
                            );
                          }

                          // Login Call
                          try {
                            Response<dynamic> responseLogin = await Dio().post(
                              "${AppConfig.apiUrl}/cidadao/login", // Use AppConfig
                              data: {
                                'email': _emailController.text,
                                'password': _passwordController.text
                              },
                              options: Options(
                                responseType: ResponseType.json,
                              ),
                            );

                            if (responseLogin.statusCode == 200 || responseLogin.statusCode == 201) {
                              // TODO: Implement secure and asynchronous storage for token and public_id
                              saveData('public_id', responseLogin.data["public_id"]);
                              saveData('token', responseLogin.data["token"]);

                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Login efetuado com sucesso!'),
                                      backgroundColor: Colors.green),
                                );
                                Navigator.popAndPushNamed(context, "/home"); // Navigate to home
                              }
                            } else {
                               if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Erro no login após cadastro: ${responseLogin.statusMessage}')),
                                );
                              }
                            }
                          } on DioException catch (e) {
                            debugPrint("DioException during login after registration: ${e.message}");
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Erro no login após cadastro: ${e.response?.data['message'] ?? e.message}')),
                              );
                            }
                          } catch (e) {
                            debugPrint("Error during login after registration: $e");
                             if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erro inesperado no login: ${e.toString()}')),
                              );
                            }
                          }
                        } else {
                           if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Erro no cadastro: ${responseLogon.statusMessage}')),
                            );
                          }
                        }
                      } on DioException catch (e) {
                        debugPrint("DioException during registration: ${e.message}");
                        if (mounted) {
                           String errorMessage = e.response?.data['message'] ?? e.message ?? "Erro desconhecido no cadastro.";
                           if (e.response?.data['errors'] != null && e.response?.data['errors'] is Map) {
                             final errors = e.response?.data['errors'] as Map;
                             if (errors.isNotEmpty) {
                               final firstError = errors.entries.first;
                               errorMessage = "${firstError.key}: ${firstError.value[0]}";
                             }
                           }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        }
                      } catch (err) {
                        debugPrint("Unexpected error during registration: $err");
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ocorreu um erro inesperado: ${err.toString()}')),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    width_: screenSize.width,
                    height_: 50.h,
                    label: _isLoading ? "Cadastrando..." : "Cadastrar",
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
