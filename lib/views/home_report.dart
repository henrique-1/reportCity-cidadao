import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({super.key});

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  @override
  Widget build(BuildContext context) {
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
          child: const SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
