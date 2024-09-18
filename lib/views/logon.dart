import 'package:flutter/material.dart';
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
    Response<dynamic> response = await Dio().get(
      "https://viacep.com.br/ws/$normalizedZipCode/json/",
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    _streetController.text = response.data['logradouro'];
    _neighborhoodController.text = response.data['bairro'];
    _cityController.text = response.data['localidade'];
    _stateController.text = response.data['uf'];
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDCDCDA),
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
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 300.w,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 22.0.sp,
                                color: const Color(0xFF262624),
                                height: 1.45.h,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Seja bem-vindo',
                                ),
                                TextSpan(
                                  text: ', ',
                                ),
                                TextSpan(
                                  text: 'realize o',
                                ),
                                TextSpan(
                                  text: " ",
                                ),
                                TextSpan(
                                  text: 'Cadastro',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "para continuar!",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ImageAsset(
                      asset: 'assets/reportCityLogo.png',
                      width_: screenSize.height / 5,
                      height_: screenSize.height / 5,
                      imageAlignment: Alignment.center,
                      hasAntiAlias: true,
                      imageFilterQuality: FilterQuality.medium,
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Form(
                      key: _logonFormKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          TextFormFieldWidget(
                            textFormFieldController: _fullNameController,
                            formKey: _logonFormKey,
                            callback: (value) {
                              if (value!.isEmpty) {
                                return "Insira seu nome completo!";
                              }
                            },
                            label: "Nome completo",
                            maxlines: 1,
                            textInputType: TextInputType.name,
                            isObscure: false,
                            //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
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
                            maxlines: 1,
                            textInputType: TextInputType.number,
                            isObscure: false,
                            //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                            textInputAction: TextInputAction.next,
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
                            textFormFieldController: _phoneController,
                            formKey: _logonFormKey,
                            callback: (value) {
                              if (value.isEmpty) {
                                return "Insira seu celular";
                              }

                              return null;
                            },
                            label: "Celular",
                            maxlines: 1,
                            textInputType: TextInputType.number,
                            isObscure: false,
                            textInputAction: TextInputAction.next,
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
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
                            maxlines: 1,
                            textInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
                            textFormFieldController: _passwordController,
                            isObscure: true,
                            //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                            textInputAction: TextInputAction.done,
                            formKey: _logonFormKey,
                            callback: (value) {
                              if (value!.isEmpty) {
                                return "Insira sua senha!";
                              }

                              return null;
                            },
                            label: "Senha",
                            maxlines: 1,
                            textInputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
                            textFormFieldController:
                                _passwordConfirmationController,
                            isObscure: true,
                            //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                            textInputAction: TextInputAction.next,
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
                            maxlines: 1,
                            textInputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormFieldWidget(
                            textFormFieldController: _zipController,
                            formKey: _logonFormKey,
                            callback: (value) {
                              if (value!.isEmpty) {
                                return "Insira seu CEP!";
                              }
                              return null;
                            },
                            label: "CEP",
                            maxlines: 1,
                            textInputType: TextInputType.number,
                            isObscure: false,
                            textInputAction: TextInputAction.next,
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            onEditComplete: () {
                              final String normalizedZipCode =
                                  UtilBrasilFields.removeCaracteres(
                                      _zipController.text);

                              getZipCodeInfo(normalizedZipCode);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        ElevatedButtonWidget(
                          callback: () {
                            Navigator.popAndPushNamed(context, "/home");
                          },
                          width_: screenSize.width,
                          height_: 50.h,
                          label: "Cadastrar",
                        ),
                      ],
                    ),
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
