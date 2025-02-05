import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cidadao/components/elevatedButton.dart';
import 'package:cidadao/components/imageAsset.dart';
import 'package:cidadao/components/textFormField.dart';

class MFARecoveryPassword extends StatefulWidget {
  final String email;
  const MFARecoveryPassword({
    super.key,
    required this.email,
  });

  @override
  State<MFARecoveryPassword> createState() => _MFARecoveryPasswordState();
}

class _MFARecoveryPasswordState extends State<MFARecoveryPassword> {
  final TextEditingController _recoveryCodeController = TextEditingController();
  final _passwordRecoveryFormKey = GlobalKey<FormState>();

  String _validatorErrorMessage = "";

  @override
  Widget build(BuildContext context) {
    final String emailCidadao = widget.email.replaceRange(
      2,
      widget.email.split("@")[0].length,
      "*" * (widget.email.split("@")[0].length - 2),
    );

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
                    height: 160.h,
                  ),
                  Form(
                    key: _passwordRecoveryFormKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            child: Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                style: GoogleFonts.inter(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Insira o',
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                  ),
                                  const TextSpan(
                                    text: 'código',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                  ),
                                  const TextSpan(
                                    text: 'que foi enviado para o email',
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: emailCidadao,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                  ),
                                  const TextSpan(
                                    text:
                                        'para prosseguir com a recuperação de senha.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormFieldWidget(
                          isEnabled: true,

                          textFormFieldController: _recoveryCodeController,
                          isObscure: false,
                          //scrollPaddingHeight: MediaQuery.of(context).viewInsets.bottom + 20,
                          textInputAction: TextInputAction.done,
                          formKey: _passwordRecoveryFormKey,
                          callback: (value) {
                            if (value.length < 8 && !value!.isEmpty) {
                              _validatorErrorMessage =
                                  "O código de verificação deve possuir ao menos 8 caracteres";
                              return "Código de verificação incorreto";
                            } else if (value!.isEmpty) {
                              _validatorErrorMessage =
                                  "Insira o código de recuperação";
                              return _validatorErrorMessage;
                            }
                            return null;
                          },
                          label: "Código de recuperação",
                          maxLines: 1,
                          textInputType: TextInputType.text,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(8)
                          ],
                          maxLengthEnforced: MaxLengthEnforcement.enforced,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 235.h,
                  ),
                  ElevatedButtonWidget(
                    callback: () {
                      if (_passwordRecoveryFormKey.currentState!.validate()) {
                        Navigator.popAndPushNamed(context, "/new_password");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _validatorErrorMessage,
                            ),
                          ),
                        );
                      }
                    },
                    width_: screenSize.width,
                    height_: 50.h,
                    label: "Prosseguir para a recuperação",
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
