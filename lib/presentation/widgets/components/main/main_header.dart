import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainHeader extends StatelessWidget {
  final TextEditingController? controller;
  const MainHeader({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomTextField(
              'Search product or any order...',
              controller: controller,
              bgColor: Theme.of(context).colorScheme.background,
            ),
          ),
          const Spacer(flex: 3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                'GROUP A',
                weight: FontWeight.w600,
                size: 12.sp,
              ),
              CustomText(
                'DAY 2',
                weight: FontWeight.w600,
                size: 11.sp,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const Spacer(flex: 3),
          Row(
            children: const [
              Icon(Icons.calendar_today),
              CustomText(
                'October 18th 2002',
              ),
            ],
          ),
          const Spacer(flex: 1),
          Container(
            height: 6.h,
            width: 15.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  '00:00:00:00',
                  size: 12.sp,
                ),
                const CustomText('Time remaining'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
