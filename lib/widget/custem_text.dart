import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustemText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustemText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    );
  }
}
