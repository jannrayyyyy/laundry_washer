import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSelectionHeader extends StatelessWidget {
  final int kg;
  final int qty;
  final int loads;
  final List bookingUids;
  const CustomSelectionHeader({
    super.key,
    required this.kg,
    required this.qty,
    required this.loads,
    required this.bookingUids,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'TOTAL',
                size: 16.sp,
                weight: FontWeight.bold,
              ),
              CustomText(
                '12567832',
                size: 11.sp,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '$kg KG & $qty QTY',
                size: 14.sp,
                weight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
              Row(
                children: [
                  const Iconify(Mdi.table_of_contents),
                  SizedBox(width: 0.5.w),
                  CustomText(
                    'SELECTED: ',
                    size: 11.sp,
                  ),
                  CustomText(
                    bookingUids.length.toString(),
                    color: Theme.of(context).primaryColor,
                    size: 11.sp,
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: CustomText(
            loads <= 1 ? '$loads LOAD' : '$loads LOADS',
            size: 12.sp,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}
