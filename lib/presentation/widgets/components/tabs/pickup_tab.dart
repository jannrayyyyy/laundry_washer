// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../cubits/bookings/bookings_cubit.dart';
import '../../custom/custom_selection_category.dart';
import '../../custom/custom_table_header.dart';

class PickUpTab extends StatefulWidget {
  final int loads;
  final int kg;
  final int qty;
  final TextEditingController searchProductController;
  final List<String> bookingUids;
  final Widget dataTable;
  final String title;
  final String subTitle;
  final Color? successColor;
  final Widget Function(BuildContext context) builder;
  const PickUpTab({
    Key? key,
    required this.loads,
    required this.kg,
    required this.qty,
    required this.searchProductController,
    required this.bookingUids,
    required this.dataTable,
    required this.title,
    required this.subTitle,
    this.successColor,
    required this.builder,
  }) : super(key: key);

  @override
  State<PickUpTab> createState() => _PickUpTabState();
}

class _PickUpTabState extends State<PickUpTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // row body
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomTableHeader(
                      bookingUids: widget.bookingUids,
                      title: widget.title,
                      subTitle: widget.subTitle,
                    ),
                    const Divider(),
                    Expanded(
                      child: widget.dataTable,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              Container(
                width: 25.w,
                padding: const EdgeInsets.all(6),
                // right content
                child: Column(
                  children: [
                    Column(
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
                                '${widget.kg} KG & ${widget.qty} QTY',
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
                                    widget.bookingUids.length.toString(),
                                    color: Theme.of(context).primaryColor,
                                    size: 11.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: CustomText(
                            widget.loads <= 1
                                ? '${widget.loads} LOAD'
                                : '${widget.loads} LOADS',
                            size: 12.sp,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: BlocBuilder<BookingCubit, BookingsState>(
                        builder: (context, state) {
                          if (state is BookingsLoaded) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Column(
                                    children: state.bookings
                                        .where((element) =>
                                            element.isSelected ?? false)
                                        .map((e) {
                                      return CustomSelectedCategory(e: e);
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is BookingsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is BookingsEmpty) {
                            return const Center(
                              child: CustomText('Empty'),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    widget.builder(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
