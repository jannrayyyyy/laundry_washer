import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:intl/intl.dart';
import 'package:laundry_washer/data/model/rider_model.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/presentation/cubits/rider/rider_cubit.dart';
import 'package:laundry_washer/presentation/widgets/custom/custom_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cubits/bookings/bookings_cubit.dart';

class CheckOutVerificationScreen extends StatefulWidget {
  final BookingEntity e;
  const CheckOutVerificationScreen({super.key, required this.e});

  @override
  State<CheckOutVerificationScreen> createState() =>
      _CheckOutVerificationScreenState();
}

class _CheckOutVerificationScreenState
    extends State<CheckOutVerificationScreen> {
  String? riderFullname;
  String? riderUid;
  @override
  void initState() {
    super.initState();
    riderUid = widget.e.riderId;
  }

  Future<RiderModel> getRider({required String riderId}) {
    return FirebaseFirestore.instance
        .collection('rider')
        .doc(riderId)
        .get()
        .then((value) => RiderModel.fromMap(value.data()!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1B1E28),
              size: 16,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image/tl_bubble.png',
                    height: 25.h,
                  ),
                  Image.asset(
                    'assets/image/tr_bubble.png',
                    height: 20.h,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/image/bl_bubble.png',
                    height: 15.h,
                  ),
                  Image.asset(
                    'assets/image/br_bubble.png',
                    height: 30.h,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        height: 40.h,
                      )
                    ],
                  ),
                  Container(
                    width: 35.w,
                    height: 40.h,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            'ITEM TO CHECK OUT DETAILS: ',
                            size: 14.sp,
                            weight: FontWeight.w600,
                            color: Colors.green.shade400,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'CATEGORY',
                              size: 12.sp,
                              weight: FontWeight.w600,
                            ),
                            CustomText(widget.e.category),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              widget.e.category == 'Mixed Clothes'
                                  ? 'KG'
                                  : 'QTY',
                              size: 12.sp,
                              weight: FontWeight.w600,
                            ),
                            CustomText(
                              widget.e.category == 'Mixed Clothes'
                                  ? widget.e.kg.toString()
                                  : widget.e.quantity.toString(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'SCHEDULE TYPE',
                              size: 12.sp,
                              weight: FontWeight.w600,
                            ),
                            CustomText(widget.e.scheduleType == 0
                                ? 'SCHEDULED'
                                : 'ASAP'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'DELIVERY DATE',
                              size: 12.sp,
                              weight: FontWeight.w600,
                            ),
                            CustomText(DateFormat('MMMM dd yyyy, hh:mm a')
                                .format(DateTime.parse(widget.e.deliveryDate))),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Divider(color: Theme.of(context).primaryColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'RIDER',
                              size: 12.sp,
                              weight: FontWeight.w600,
                            ),
                            FutureBuilder<RiderModel>(
                              future: getRider(riderId: riderUid ?? ""),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  show(snapshot.data?.fullname ?? '');
                                  riderFullname = snapshot.data?.fullname;
                                  show('riderfullname val1: $riderFullname');
                                  return BlocBuilder<RiderCubit, RiderState>(
                                      builder: (ctx, state) {
                                    if (state is RiderLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is RiderLoaded) {
                                      final riderState = state.riders;
                                      // riderFullname = snapshot.data?.fullname;
                                      show(
                                          'riderfullname val2: $riderFullname');
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: riderFullname,
                                          items: riderState.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.fullname,
                                              child: CustomText(e.fullname),
                                              onTap: () {
                                                riderUid = e.uid;
                                                show('riderUid val: $riderUid');
                                                getRider(
                                                    riderId: riderUid ?? "");
                                              },
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            setState(() {
                                              riderFullname = v;
                                            });
                                          },
                                        ),
                                      );
                                    } else if (state is RiderEmpty) {
                                      return const Center(
                                        child: CustomText('EMPTY'),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  });
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CustomText('Fetching...'),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        BlocListener<BookingCubit, BookingsState>(
                          listener: (context, state) {
                            if (state is BookingsLoading) {
                              showDialog(
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                },
                                context: context,
                              );
                            }
                          },
                          child: BtnFilled(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return CustomDialog(
                                      title: 'Are you sure?',
                                      cancelTitle: 'Cancel',
                                      successTitle: 'Proceed',
                                      onTap: () {
                                        context
                                            .read<BookingCubit>()
                                            .updateBookingStatus(
                                          [widget.e.uid ?? ''],
                                          6,
                                        );
                                        context
                                            .read<BookingCubit>()
                                            .changeRider(
                                              uid: widget.e.uid ?? '',
                                              riderUid: riderUid ?? '',
                                              context: context,
                                            );
                                      },
                                      content:
                                          'Make sure to check double before\nclicking the button',
                                    );
                                  });
                            },
                            text: 'CHECK OUT',
                            radius: 8,
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
