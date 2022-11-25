import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDataTableLabel extends StatelessWidget {
  final String label;
  final int? flex;
  const CustomDataTableLabel({super.key, required this.label, this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(1.h),
        child: CustomText(
          label,
          color: Colors.white,
          size: 12.sp,
        ),
      ),
    );
  }
}
