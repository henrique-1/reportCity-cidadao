import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
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
    return OutlinedButton(
      onPressed: callback,
      style: ButtonStyle(
        alignment: Alignment.center,
        fixedSize: WidgetStatePropertyAll(
          Size(width_, height_),
        ),
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.2), // Usando a cor primária com opacidade
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          color: Theme.of(context)
              .colorScheme
              .primary, // Usando a cor primária do tema          fontWeight: FontWeight.w500,
          fontWeight: FontWeight.w500,
          height: 1.5.h,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
