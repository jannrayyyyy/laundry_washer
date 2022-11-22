import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? ontap;
  final Color? textColor;
  final double? height;
  final double? radius;

  const CustomButton({
    super.key,
    required this.text,
    this.ontap,
    this.textColor,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height ?? 55,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        child: CustomBtnText(
          text,
          weight: FontWeight.bold,
          color: textColor ?? Colors.white,
          size: 11.sp,
        ),
      ),
    );
  }
}
