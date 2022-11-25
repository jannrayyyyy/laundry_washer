import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/presentation/widgets/components/dashboard/dashboard_datatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/custom_function.dart';
import '../../cubits/record/record_cubit.dart';
import '../../cubits/today_booking/today_booking_cubit.dart';
import '../../widgets/components/dashboard/dashboard_table_header.dart';

class Darshboard extends StatefulWidget {
  const Darshboard({super.key});

  @override
  State<Darshboard> createState() => _DarshboardState();
}

class _DarshboardState extends State<Darshboard> {
  RefreshController refreshController1 =
      RefreshController(initialRefresh: false);
  int limit = 10;
  @override
  void initState() {
    super.initState();
    context.read<RecordCubit>().fetchRecords(limit: limit);
  }

  void onRefresh() {
    show('onrefresh');

    limit = 10;
    context.read<RecordCubit>().fetchRecords(
          limit: 10,
        );
    refreshController1.refreshCompleted();
  }

  void onLoading() async {
    show('onLoading');
    limit += 5;
    await context.read<RecordCubit>().fetchRecords(
          limit: limit,
          canLoad: false,
        );

    refreshController1.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBookingCubit, TodayBookingState>(
      builder: (context, state) {
        if (state is TodayBookingLoaded) {
          final today = CustomFunction.getDateToday();
          //*today's Data
          final todayUpcoming = state.bookings.where((element) {
            return element.bookingStatus == 2 &&
                (DateTime.parse(element.createdAt).isAfter(
                      today['start'],
                    ) &&
                    DateTime.parse(element.createdAt).isBefore(
                      today['end'],
                    ));
          }).toList();
          final todayInProgress = state.bookings.where((element) {
            return element.bookingStatus == 4 &&
                (DateTime.parse(element.createdAt).isAfter(
                      today['start'],
                    ) &&
                    DateTime.parse(element.createdAt).isBefore(
                      today['end'],
                    ));
          }).toList();
          final todayCompleted = state.bookings.where((element) {
            return (element.bookingStatus == 7 ||
                    element.bookingStatus == 200) &&
                (DateTime.parse(element.createdAt).isAfter(
                      today['start'],
                    ) &&
                    DateTime.parse(element.createdAt).isBefore(
                      today['end'],
                    ));
          }).toList();
          //*all datas
          final upcoming = state.bookings.where((element) {
            return element.bookingStatus == 2;
          }).toList();
          final inProgress = state.bookings.where((element) {
            return element.bookingStatus == 4;
          }).toList();
          final completed = state.bookings.where((element) {
            return element.bookingStatus == 7;
          }).toList();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'TODAY OVERVIEW',
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                    Wrap(
                      spacing: 4.w,
                      children: [
                        buildOverviewContainer(
                          title: 'UPCOMING ITEMS',
                          x: todayUpcoming.length,
                          color: Colors.amber,
                        ),
                        buildOverviewContainer(
                          title: 'WASH IN PROGRESS',
                          x: todayInProgress.length,
                          color: Theme.of(context).primaryColor,
                        ),
                        buildOverviewContainer(
                          title: 'COMPLETED',
                          x: todayCompleted.length,
                          color: Colors.green.shade400,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'TOTAL OVERVIEW',
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                    Wrap(
                      spacing: 4.w,
                      children: [
                        buildOverviewContainer(
                          title: 'UPCOMING ITEMS',
                          x: upcoming.length,
                          color: Colors.amber,
                        ),
                        buildOverviewContainer(
                          title: 'WASH IN PROGRESS',
                          x: inProgress.length,
                          color: Theme.of(context).primaryColor,
                        ),
                        buildOverviewContainer(
                          title: 'COMPLETED',
                          x: completed.length,
                          color: Colors.green.shade400,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'RECORDS',
                              size: 16.sp,
                              weight: FontWeight.w900,
                            ),
                            CustomText(
                              'All records of your group',
                              size: 12.sp,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        const Spacer(flex: 6),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            'Search product or any order',
                            controller: TextEditingController(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const DashboardTableHeader(),
                    SizedBox(
                      height: 32.h,
                      child: BlocBuilder<RecordCubit, RecordState>(
                        builder: (context, state) {
                          if (state is RecordLoaded) {
                            return SmartRefresher(
                              controller: refreshController1,
                              enablePullDown: true,
                              enablePullUp: true,
                              onRefresh: onRefresh,
                              header: WaterDropHeader(
                                waterDropColor: Theme.of(context).primaryColor,
                              ),
                              // footer: CustomFooter(
                              //   builder: (context, mode) {
                              //     Widget body;
                              //     if (mode == LoadStatus.loading) {
                              //       body = CircularProgressIndicator(
                              //         color: Theme.of(context).primaryColor,
                              //       );
                              //     } else if (mode == LoadStatus.failed) {
                              //       body =
                              //           const Text("Load Failed!Click retry!");
                              //     } else if (mode == LoadStatus.canLoading) {
                              //       body = const Text("release to load more");
                              //     } else {
                              //       body = const Text("No more Data");
                              //     }
                              //     return SizedBox(
                              //       height: 32.0,
                              //       child: Center(child: body),
                              //     );
                              //   },
                              // ),
                              onLoading: onLoading,
                              child: SingleChildScrollView(
                                child: Column(
                                    children: state.bookings.map((e) {
                                  return DashboardDataTable(booking: e);
                                }).toList()),
                              ),
                            );
                          } else if (state is RecordLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else if (state is RecordEmpty) {
                            return const Center(
                              child: CustomBtnText('EMPTY'),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                )
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget buildOverviewContainer({
    required String title,
    required int x,
    required Color color,
  }) {
    return Container(
      height: 25.h,
      width: 25.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            title,
            size: 14.sp,
            weight: FontWeight.w600,
          ),
          CustomText(x.toString(),
              size: 20.sp, weight: FontWeight.w600, color: color)
        ],
      ),
    );
  }
}
