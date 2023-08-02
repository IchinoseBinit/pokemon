import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FutureResolver {
  Widget showError({
    double? height,
    String? message,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height ?? 30.h, horizontal: 16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem_outlined,
              color: Colors.red,
              size: 48.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              message ?? "Cant load the data at the moment",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget showLoading({double? height}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height ?? 30.h),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
