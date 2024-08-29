import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key, required data});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("Tap");
      },
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          color: const Color(0xFFcee4d2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Denuncia 1",
                style: GoogleFonts.inter(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF122115),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Descrição denuncia 1",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF122115),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 100.w,
                    height: 150.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: size.width,
                child: const Text(
                  "Visualizar denuncia",
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
