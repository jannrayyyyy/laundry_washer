import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSelectedCategory extends StatelessWidget {
  final BookingEntity e;
  const CustomSelectedCategory({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      height: 70,
      padding: EdgeInsets.all(1.h),
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF7F7F9),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(1, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            e.category == "Mixed Clothes"
                ? 'assets/image/shirt.png'
                : 'assets/image/comforter.png',
          ),
          SizedBox(
            width: 0.5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                e.category.toUpperCase(),
                weight: FontWeight.w600,
              ),
              Row(
                children: [
                  CustomText(
                    e.category == "Mixed Clothes"
                        ? '${e.kg} KG'
                        : '${e.quantity} QTY',
                    size: 13.sp,
                    color: Theme.of(context).primaryColor,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    ' (${e.load} LOADS)',
                    size: 10.sp,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: null,
            icon: Iconify(
              Ic.sharp_remove_circle_outline,
              color: Theme.of(context).colorScheme.errorContainer,
            ),
          )
        ],
      ),
    );
  }
}
