import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey _updateUserInfoFormKey = GlobalKey<FormState>();

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

  Future<void> getZipCodeInfo(String normalizedZipCode) async {
    Response<dynamic> response = await Dio().get(
      "https://viacep.com.br/ws/$normalizedZipCode/json/",
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    _streetController.text = response.data['logradouro'];
    _houseNumberController.text = response.data['unidade'];
    _complementController.text = response.data['complemento'];
    _neighborhoodController.text = response.data['bairro'];
    _cityController.text = response.data['localidade'];
    _stateController.text = response.data['uf'];
  }

  @override
  void setState(VoidCallback fn) {
    _fullNameController.text = "Nicholas Meizikas Pego";
    _cpfController.text = "495.111.108-02";
    _phoneController.text = "(19) 99824-8300";
    _emailController.text = "nick@gmail.com";
    _passwordController.text = "123456789";
    _passwordConfirmationController.text = "123456789";
    _zipController.text = "13875-264";
    _streetController.text = "Rua Sete";
    _houseNumberController.text = "649";
    _complementController.text = "";
    _neighborhoodController.text = "Jardim Nova República (2ª Etapa)";
    _cityController.text = "São João da Boa Vista";
    _stateController.text = "São Paulo";
    super.setState(fn);
  }

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 16.h,
        ),
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
                          child: Text(
                            "Alterar cadastro",
                            style: GoogleFonts.inter(
                                fontSize: 24.0.sp,
                                color: const Color(0xFF122115),
                                height: 1.45.h,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          userProfilePicture(size.height / 5, size.height / 5),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Form(
                        key: _updateUserInfoFormKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            fullnameTextField(size),
                            // emailTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            cpfTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            phoneTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            emailTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            passwordTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            passwordConfirmationTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            zipTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            streetTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            houseNumberTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            complementTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            neighborhoodTextField(size),
                            SizedBox(
                              height: 8.h,
                            ),
                            cityTextField(size),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    signInButton(size),
                    SizedBox(
                      height: 64.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfilePicture(double height_, double width_) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: Image.asset(
        'assets/nick.jpeg',
        width: width_,
        height: height_,
      ),
    );
  }

  Widget fullnameTextField(Size size) {
    return TextFormField(
      controller: _fullNameController,
      maxLines: 1,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        return value!.isEmpty ? "Insira seu nome!" : null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Nome completo",
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

  Widget cpfTextField(Size size) {
    return TextFormField(
      enabled: false,
      controller: _cpfController,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CpfInputFormatter(),
      ],
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira seu CPF!";
        }

        if (!GetUtils.isCpf(value)) {
          return "CPF incorreto!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "CPF",
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
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF8b8a84),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget phoneTextField(Size size) {
    return TextFormField(
      controller: _phoneController,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        return value!.isEmpty ? "Insira seu nome!" : null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Celular",
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

  Widget emailTextField(Size size) {
    return TextFormField(
      controller: _emailController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira seu e-mail!";
        }

        if (!EmailValidator.validate(value)) {
          return "E-mail incorreto!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "E-mail",
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

  Widget passwordTextField(Size size) {
    return TextFormField(
      controller: _passwordController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira sua senha!";
        }

        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Senha",
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

  Widget passwordConfirmationTextField(Size size) {
    return TextFormField(
      controller: _passwordConfirmationController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira sua senha!";
        }

        if (_passwordController.text != _passwordConfirmationController.text) {
          return "As senhas devem ser idênticas!";
        }

        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Confirmação de senha",
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

  Widget zipTextField(Size size) {
    return TextFormField(
      controller: _zipController,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CepInputFormatter(),
      ],
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira seu CEP!";
        }
        return null;
      },
      onEditingComplete: () {
        final String normalizedZipCode =
            UtilBrasilFields.removeCaracteres(_zipController.text);

        getZipCodeInfo(normalizedZipCode);
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "CEP",
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

  Widget streetTextField(Size size) {
    return TextFormField(
      controller: _streetController,
      maxLines: 1,
      keyboardType: TextInputType.streetAddress,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira a rua onde você mora!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Rua",
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

  Widget houseNumberTextField(Size size) {
    return TextFormField(
      controller: _houseNumberController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira o número da sua residência!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Número",
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

  Widget complementTextField(Size size) {
    return TextFormField(
      controller: _complementController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Complemento",
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

  Widget neighborhoodTextField(Size size) {
    return TextFormField(
      controller: _neighborhoodController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira o bairro onde você mora!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Bairro",
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

  Widget cityTextField(Size size) {
    return TextFormField(
      controller: _cityController,
      maxLines: 1,
      cursorColor: const Color(0xFF3A6642),
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira a cidade onde você mora!";
        }
        return null;
      },
      style: GoogleFonts.inter(
        fontSize: 17.sp,
        color: const Color(0xFF37623A),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Cidade",
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

  Widget signInButton(Size size) {
    return ElevatedButton(
      onPressed: () {},
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
        "Atualizar Cadastro",
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
