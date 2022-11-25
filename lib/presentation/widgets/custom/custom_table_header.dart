import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTableHeader extends StatelessWidget {
  final List? bookingUids;
  final String title;
  final String subTitle;

  const CustomTableHeader({
    super.key,
    this.bookingUids,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                weight: FontWeight.bold,
                size: 14.sp,
              ),
              CustomText(
                subTitle,
                size: 10.sp,
                weight: FontWeight.w400,
              )
            ],
          ),
          const Spacer(),
          bookingUids != null
              ? Row(
                  children: [
                    const Iconify(Mdi.table_of_contents),
                    SizedBox(width: 0.5.w),
                    const CustomText('SELECTED: '),
                    CustomText(
                      (bookingUids?.length).toString(),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              : const SizedBox(),
          SizedBox(width: 2.w),
          Row(
            children: [
              const Iconify(Ic.outline_access_time),
              SizedBox(width: 0.5.w),
              const CustomText('TIME: '),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      DateFormat.jm().format(DateTime.now()),
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
