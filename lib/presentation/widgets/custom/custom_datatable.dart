import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDataTable extends StatelessWidget {
  final BookingEntity e;
  final bool isSelected;
  const CustomDataTable({super.key, required this.e, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.5.h),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                e.category,
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                e.kg.toString(),
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                e.load.toString(),
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                e.scheduleType.toString(),
                size: 12.sp,
              ),
            ),
          ),
          isSelected
              ? Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                )
              : Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
