import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/data/model/rider_model.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckoutDataTable extends StatefulWidget {
  final BookingEntity e;
  const CheckoutDataTable({super.key, required this.e});

  @override
  State<CheckoutDataTable> createState() => _CheckoutDataTableState();
}

class _CheckoutDataTableState extends State<CheckoutDataTable> {
  String? riderFullName;
  String? riderUid;
  bool isloaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      isloaded = true;
    });
  }

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
                widget.e.category,
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                widget.e.kg.toString(),
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                widget.e.load.toString(),
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                widget.e.scheduleType == 0 ? 'SCHEDULED' : 'ASAP',
                size: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                FutureBuilder<RiderModel>(
                  future: FirebaseFirestore.instance
                      .collection('rider')
                      .doc(widget.e.riderId)
                      .get()
                      .then((value) => RiderModel.fromMap(value.data()!)),
                  builder: (context, snapshot) {
                    riderFullName = snapshot.data?.fullname ?? '';
                    return CustomText(riderFullName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
