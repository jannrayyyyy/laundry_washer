import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomEmptyContainer extends StatelessWidget {
  const CustomEmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/image/empty.png',
        height: 25.h,
        width: 25.h,
      ),
    );
  }
}
