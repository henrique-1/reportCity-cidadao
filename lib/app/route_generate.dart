import 'package:cidadao/components/detailedReport.dart';
import 'package:cidadao/components/detailedReport2.dart';
import 'package:cidadao/components/reportForm.dart';
import 'package:cidadao/views/forgotPassword.dart';
import 'package:cidadao/views/home.dart';
import 'package:cidadao/views/login.dart';
import 'package:cidadao/views/passwordRecovery.dart';
import 'package:cidadao/views/registerReport.dart';
import 'package:cidadao/views/signin.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/signin":
        return MaterialPageRoute(builder: (_) => const Signin());
      case "/recoverySMS":
        return MaterialPageRoute(builder: (_) => const ForgotPasswordSMS());
      case "/changePassword":
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case "/home":
        return MaterialPageRoute(builder: (_) => const Home());
      case "/cameraReport":
        return MaterialPageRoute(builder: (_) => const RegisterReport());
      case "/reportForm":
        return MaterialPageRoute(builder: (_) => const ReportForm());
      case "/detailedReport":
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments as List;
            return DetailedReport(
              reportInfo: args[0].toString(),
            );
          },
        );
      case "/detailedReport2":
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments as List;
            return DetailedReport2(
              reportInfo: args[0].toString(),
            );
          },
        );
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tela não encontrada"),
          ),
          body: const Center(
            child: Text("Tela não encontrada"),
          ),
        );
      },
    );
  }
}
