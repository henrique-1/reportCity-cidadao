import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailedReport2 extends StatefulWidget {
  const DetailedReport2({super.key, required reportInfo});

  @override
  State<DetailedReport2> createState() => _DetailedReport2State();
}

class _DetailedReport2State extends State<DetailedReport2> {
  final TextEditingController _feedbackController = TextEditingController();

  String? feedback = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDCDCDA),
      body: SafeArea(
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: Text(
                                "Calçada quebrada",
                                style: GoogleFonts.inter(
                                  fontSize: 24.0.sp,
                                  color: const Color(0xFF122115),
                                  height: 1.45.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width,
                              child: Text(
                                "Cancelado",
                                style: GoogleFonts.inter(
                                  fontSize: 14.0.sp,
                                  color: const Color(0xFFbc6262),
                                  height: 1.45.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF494845).withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              24.r,
                            ),
                            color: const Color(0xFFcee4d2),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: size.width,
                                margin: EdgeInsets.only(
                                  top: 4.h,
                                  bottom: 4.h,
                                ),
                                child: Text(
                                  "Calçada da Rua Coronel José Procópio está toda quebrada por conta das árvores. Pedestres precisam utilizar a rua para poder andar por essa rua, pois é impossível usar a calçada.",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.0.sp,
                                    color: const Color(0xFF2e4d34),
                                    height: 1.45.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width,
                                margin: EdgeInsets.only(
                                  top: 4.h,
                                  bottom: 4.h,
                                ),
                                child: Text(
                                  "Feedback",
                                  style: GoogleFonts.inter(
                                    fontSize: 32.0.sp,
                                    color: const Color(0xFF122115),
                                    height: 1.45.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _feedbackController,
                                maxLines: 8,
                                enabled: true,
                                cursorColor: const Color(0xFF3A6642),
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  color: const Color(0xFF37623A),
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Feedback",
                                  alignLabelWithHint: true,
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
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    feedback = _feedbackController.text;
                                  });
                                },
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
                                  "Enviar",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: const Color(0xFFf6f6f6),
                                    fontWeight: FontWeight.w600,
                                    height: 1.5.h,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: size.width,
                                margin: EdgeInsets.only(
                                  top: 4.h,
                                  bottom: 4.h,
                                ),
                                child: Text("$feedback"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
