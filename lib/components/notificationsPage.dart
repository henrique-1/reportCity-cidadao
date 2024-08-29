import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 4,
          //   itemBuilder: (context, index) {
          //     final size = MediaQuery.of(context).size;
          //     return GestureDetector(
          //       onTap: () {
          //         print("Tap");
          //       },
          //       child: Container(
          //         width: size.width,
          //         height: 130.h,
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             color: Colors.black,
          //             width: 2.w,
          //           ),
          //           borderRadius: BorderRadius.circular(
          //             8.r,
          //           ),
          //           color: const Color(0xFFcee4d2),
          //         ),
          //         margin: EdgeInsets.symmetric(
          //           horizontal: 0.w,
          //           vertical: 4.h,
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.stretch,
          //           children: [
          //             Container(
          //               child: Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   Icon(Icons.circle, size: 110.dg),
          //                   Positioned(
          //                     bottom: 15.h,
          //                     right: 5.w,
          //                     child: Container(
          //                       alignment: Alignment.bottomRight,
          //                       child: Stack(
          //                         alignment: Alignment.center,
          //                         children: [
          //                           Icon(Icons.circle, size: 45.dg),
          //                           const Icon(Icons.upgrade,
          //                               color: Colors.white)
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               width: 307.w,
          //               child: Column(
          //                 children: [
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(
          //                       horizontal: 2.w,
          //                       vertical: 2.h,
          //                     ),
          //                     child: Text.rich(
          //                       textAlign: TextAlign.left,
          //                       TextSpan(
          //                         style: GoogleFonts.inter(
          //                           fontSize: 15.0.sp,
          //                           color: const Color(0xFF010101),
          //                         ),
          //                         children: const [
          //                           TextSpan(
          //                             text: 'Carlos',
          //                             style: TextStyle(
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                           TextSpan(text: ' '),
          //                           TextSpan(
          //                               text:
          //                                   'alterou o status da sua denuncia.'),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(
          //                       horizontal: 2.w,
          //                       vertical: 2.h,
          //                     ),
          //                     child: Text.rich(
          //                       textAlign: TextAlign.left,
          //                       TextSpan(
          //                         style: GoogleFonts.inter(
          //                           fontSize: 15.0.sp,
          //                           color: const Color(0xFF010101),
          //                         ),
          //                         children: const [
          //                           TextSpan(text: 'O status da denuncia'),
          //                           TextSpan(text: ' '),
          //                           TextSpan(
          //                               text:
          //                                   "'Buraco na Av. Dr. Oscar Pirajá Martins'"),
          //                           TextSpan(text: ' '),
          //                           TextSpan(text: 'foi alterado para'),
          //                           TextSpan(text: ' '),
          //                           TextSpan(
          //                             text: 'Em Andamento',
          //                             style: TextStyle(
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   const Spacer(),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 4,
          //                       vertical: 4,
          //                     ),
          //                     child: Container(
          //                       alignment: Alignment.bottomLeft,
          //                       child: Text(
          //                         "27/08/2024 09:15",
          //                         style: GoogleFonts.inter(
          //                           fontSize: 15.0.sp,
          //                           fontWeight: FontWeight.w600,
          //                           color: const Color(0xFF010101),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Tap");
                      },
                      child: Container(
                        width: size.width,
                        height: 130.h,
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
                        margin: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.circle, size: 110.dg),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.asset(
                                      'assets/henrique.jpg',
                                      width: 90.dg,
                                      height: 90.dg,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    right: 5.w,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 45.dg,
                                            color: const Color(0xFF3a6642),
                                          ),
                                          const Icon(Icons.upgrade,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 307.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: 'Henrique',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text:
                                                  'alterou o status da sua denuncia.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                              text: 'O status da denuncia'),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text: "'Buraco na Rua São João'"),
                                          TextSpan(text: ' '),
                                          TextSpan(text: 'foi alterado para'),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                            text: 'Em Andamento',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "27/08/2024 09:15",
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF010101),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Tap 2");
                      },
                      child: Container(
                        width: size.width,
                        height: 130.h,
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
                        margin: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.circle, size: 110.dg),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.asset(
                                      'assets/suzana.jpg',
                                      width: 90.dg,
                                      height: 90.dg,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    right: 5.w,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 45.dg,
                                            color: const Color(0xFF0070b4),
                                          ),
                                          const Icon(Icons.comment,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 307.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: 'Suzana',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text:
                                                  'respondeu ao feedback da sua denuncia.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                              text:
                                                  '"A prefeitura de São João da Boa Vista agradece seu feedback..."'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "27/08/2024 08:31",
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF010101),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Tap");
                      },
                      child: Container(
                        width: size.width,
                        height: 130.h,
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
                        margin: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.circle, size: 110.dg),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.asset(
                                      'assets/pereda.jpg',
                                      width: 90.dg,
                                      height: 90.dg,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    right: 5.w,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(Icons.circle,
                                              size: 45.dg,
                                              color: const Color(0xFF3a6642)),
                                          const Icon(Icons.check,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 307.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: 'Vinicius',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text:
                                                  'alterou o status da sua denuncia.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                              text: 'O status da denuncia'),
                                          TextSpan(text: ' '),
                                          TextSpan(text: "'Árvore na fiação'"),
                                          TextSpan(text: ' '),
                                          TextSpan(text: 'foi alterado para'),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                            text: 'Concluído',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "26/08/2024 17:48",
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF010101),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Tap");
                      },
                      child: Container(
                        width: size.width,
                        height: 130.h,
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
                        margin: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.circle, size: 110.dg),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.asset(
                                      'assets/tais.jpg',
                                      width: 90.dg,
                                      height: 90.dg,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    right: 5.w,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 45.dg,
                                            color: const Color(0xFF3a6642),
                                          ),
                                          const Icon(Icons.close,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 307.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: 'Tais',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text:
                                                  'alterou o status da sua denuncia.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.left,
                                      TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          color: const Color(0xFF010101),
                                        ),
                                        children: const [
                                          TextSpan(
                                              text: 'O status da denuncia'),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                              text:
                                                  "'Árvore quebrando calçada'"),
                                          TextSpan(text: ' '),
                                          TextSpan(text: 'foi alterado para'),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                            text: 'Cancelado',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: '.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "26/08/2024 15:56",
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF010101),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
