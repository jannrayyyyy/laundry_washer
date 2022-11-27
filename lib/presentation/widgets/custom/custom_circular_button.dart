import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomCircularButton extends StatelessWidget {
  final Color? color;
  final String text;
  final String label;
  const CustomCircularButton({
    super.key,
    this.color,
    required this.text,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Container(
          height: 3.w,
          width: 3.w,
          margin: EdgeInsets.symmetric(vertical: 1.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: CustomText(
            text,
            size: 14.sp,
            color: Colors.white,
          ),
        ),
        CustomText(
          label,
          size: 10.sp,
        ),
      ],
    );
  }
}
