import 'package:flutter/material.dart';
import 'package:general/service/print.dart';
import 'package:general/widgets/text.dart';
import 'package:intl/intl.dart';
import 'package:laundry_washer/core/utils/custom_function.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardDataTable extends StatelessWidget {
  final BookingEntity booking;
  const DashboardDataTable({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    show(booking.bookingStatus);
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
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                '0',
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                booking.category,
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                booking.kg.toString(),
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                booking.quantity.toString(),
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                booking.load.toString(),
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                CustomFunction.getSchedType(booking.scheduleType),
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                CustomFunction.getStatus(booking.bookingStatus),
                size: 11.sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                DateFormat('MMMM dd yyyy, hh:mm a')
                    .format(DateTime.parse(booking.deliveryDate)),
                size: 11.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                booking.scheduleType.toString(),
                size: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
