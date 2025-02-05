import 'dart:io';

import 'package:cidadao/components/elevatedButton.dart';
import 'package:cidadao/components/imageAsset.dart';
import 'package:cidadao/components/outlinedButton.dart';
import 'package:cidadao/components/textButton.dart';
import 'package:cidadao/components/textFormField.dart';
import 'package:cidadao/functions/save_cache.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

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
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: SizedBox(
                  //     width: 300.w,
                  //     child: Center(
                  //       child: Text.rich(
                  //         TextSpan(
                  //           style: GoogleFonts.inter(
                  //             fontSize: 22.0.sp,
                  //             color: const Color(0xFF262624),
                  //             height: 1.45.h,
                  //           ),
                  //           children: const [
                  //             TextSpan(
                  //               text: 'Seja bem-vindo',
                  //             ),
                  //             TextSpan(
                  //               text: ', ',
                  //             ),
                  //             TextSpan(
                  //               text: 'realize o',
                  //             ),
                  //             TextSpan(
                  //               text: " ",
                  //             ),
                  //             TextSpan(
                  //               text: 'Login',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 decoration: TextDecoration.underline,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: " ",
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: "para continuar!",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                    height: 150.h,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        TextFormFieldWidget(
                          isEnabled: true,
                          textFormFieldController: _emailController,
                          isObscure: false,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.next,
                          formKey: _loginFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira seu e-mail!";
                            }

                            if (!EmailValidator.validate(value)) {
                              return "E-mail incorreto!";
                            }
                            return null;
                          },
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(255)
                          ],
                          label: "E-mail",
                          maxLines: 1,
                          textInputType: TextInputType.emailAddress,
                          //maxLength: 255,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _passwordController,
                          isObscure: true,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.done,
                          formKey: _loginFormKey,
                          callback: (value) {
                            if (value!.isEmpty) {
                              return "Insira sua senha!";
                            }

                            return null;
                          },
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(60)
                          ],
                          label: "Senha",

                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          //maxLength: 60,
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButtonWidget(
                            callback: () {
                              Navigator.pushNamed(
                                context,
                                "/recovery_password",
                                arguments: _emailController.text,
                              );
                            },
                            buttonStyle: ButtonStyle(
                              fixedSize: WidgetStatePropertyAll(
                                Size(
                                  160.w,
                                  20.h,
                                ),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Theme.of(context)
                                    .colorScheme
                                    .onSurface, // Usando a cor onSurface, que deve contrastar bem com o fundo
                              ),
                            ),
                            buttonText: Text(
                              "Esqueceu sua senha?",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF494845),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  ElevatedButtonWidget(
                    callback: () async {
                      try {
                        if (_loginFormKey.currentState!.validate()) {
                          Response<dynamic> response = await Dio().post(
                            "https://reportcity.ddns.net:3333/cidadao/login",
                            data: {
                              'email': _emailController.text,
                              'password': _passwordController.text
                            },
                            options: Options(
                              responseType: ResponseType.json,
                            ),
                          );

                          if (response.statusCode == 200) {
                            saveData('public_id', response.data["public_id"]);
                            saveData('token', response.data["token"]);
                            Navigator.popAndPushNamed(context, "/home");
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Insira os seus dados corretamente!',
                              ),
                            ),
                          );
                        }
                      } catch (err) {
                        print(err);
                      }
                    },
                    width_: screenSize.width,
                    height_: 50.h,
                    label: "Logar",
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Expanded(
                          flex: 2,
                          child: Divider(
                            color: Color(0xFF9e9d99),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Não possui uma conta?",
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
                          flex: 2,
                          child: Divider(
                            color: Color(0xFF9e9d99),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  OutlinedButtonWidget(
                    callback: () {
                      Navigator.pushNamed(context, "/logon");
                    },
                    width_: screenSize.width,
                    height_: 50.h,
                    label: "Criar uma conta",
                  ),

                  // Expanded(
                  //   flex: 2,
                  //   child: Flex(
                  //     direction: Axis.vertical,
                  //     children: [
                  //       ElevatedButtonWidget(
                  //         callback: () {
                  //           if (_loginFormKey.currentState!.validate()) {
                  //             Navigator.popAndPushNamed(context, "/home");
                  //           } else {
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               const SnackBar(
                  //                 content: Text(
                  //                   'Insira os seus dados corretamente!',
                  //                 ),
                  //               ),
                  //             );
                  //           }
                  //         },
                  //         width_: screenSize.width,
                  //         height_: 50.h,
                  //         label: "Logar",
                  //       ),
                  //       SizedBox(
                  //         height: 25.h,
                  //       ),
                  //       SizedBox(
                  //         height: 20.h,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             const Expanded(
                  //               flex: 2,
                  //               child: Divider(
                  //                 color: Color(0xFF9e9d99),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               flex: 3,
                  //               child: Text(
                  //                 "Não possui uma conta?",
                  //                 textAlign: TextAlign.center,
                  //                 style: GoogleFonts.inter(
                  //                   fontSize: 12.sp,
                  //                   color:
                  //                       const Color.fromARGB(255, 77, 71, 50),
                  //                   fontWeight: FontWeight.w500,
                  //                   height: 1.67.sp,
                  //                 ),
                  //               ),
                  //             ),
                  //             const Expanded(
                  //               flex: 2,
                  //               child: Divider(
                  //                 color: Color(0xFF9e9d99),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 25.h,
                  //       ),
                  //       OutlinedButtonWidget(
                  //         callback: () {
                  //           Navigator.pushNamed(context, "/logon");
                  //         },
                  //         width_: screenSize.width,
                  //         height_: 50.h,
                  //         label: "Criar uma conta",
                  //       )
                  //     ],
                  //   ),
                  // ),
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
