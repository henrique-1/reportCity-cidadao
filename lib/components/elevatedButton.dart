import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.callback,
    required this.width_,
    required this.height_,
    required this.label,
  });

  final callback;
  final double width_;
  final double height_;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        alignment: Alignment.center,
        fixedSize: WidgetStatePropertyAll(
          Size(width_, height_),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context)
              .colorScheme
              .primary, // Usando a cor primária do tema
        ),
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.2), // Usando a cor primária com opacidade
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          height: 1.5.h,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
