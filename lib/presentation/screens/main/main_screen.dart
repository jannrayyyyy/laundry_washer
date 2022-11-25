// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:group_button/group_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:laundry_washer/main.dart';
import 'package:laundry_washer/presentation/cubits/auth/auth_cubit.dart';
import 'package:laundry_washer/presentation/cubits/bookings/bookings_cubit.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:laundry_washer/presentation/cubits/today_booking/today_booking_cubit.dart';
import 'package:laundry_washer/presentation/screens/main/dashboard.dart';
import 'package:laundry_washer/presentation/widgets/components/checkout/checkout_tab.dart';
import 'package:laundry_washer/presentation/widgets/components/received/received_tab.dart';
import 'package:laundry_washer/presentation/widgets/custom/custom_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../domain/entity/booking_entity.dart';
import '../../widgets/components/main/main_header.dart';
import '../../widgets/components/ready_to_deliver/ready_to_deliver_tab.dart';
import '../../widgets/components/wash_In_progress/wash_in_progress_tab.dart';
import '../../widgets/custom/custom_circular_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchProductController = TextEditingController();
  final groupController = GroupButtonController();
  final pageController = PageController(initialPage: 4);
  final List<String> bookingUids = [];
  int pageIndex = 0;
  int loads = 0;
  int kg = 0;
  int qty = 0;
  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().streamBookings();
    context.read<TodayBookingCubit>().fetchTodaysBookings();
    context
        .read<GroupCubit>()
        .fetchMyGroup(uid: globalSharedPreferences?.getString('uid') ?? '');
    // groupController.selectIndex(0);
    pageIndex = pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    show(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: 100.h,
            width: 6.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Image.asset(
                  'assets/image/logo.png',
                  height: 5.w,
                  width: 5.w,
                ),
                SizedBox(height: 2.h),
                Builder(builder: (context) {
                  List<BookingEntity> bookings = [];
                  final bookingState = context.watch<BookingCubit>().state;
                  if (bookingState is BookingsLoaded) {
                    bookings.addAll(bookingState.bookings);
                  }
                  return GroupButton(
                    controller: groupController,
                    buttons: const [1, 2, 3, 4],
                    onSelected: (value, index, isSelected) {
                      pageController.jumpToPage(value - 1);
                      for (var booking in bookings) {
                        if (booking.isSelected!) {
                          booking.isSelected = false;
                          setState(() {});
                          kg = 0;
                          qty = 0;
                          loads = 0;
                          bookingUids.clear();
                        }
                      }
                      // bookingUids.clear();
                    },
                    buttonBuilder: (selected, value, context) {
                      return CustomCircularButton(
                        text: value.toString(),
                        color: selected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.onSecondary,
                      );
                    },
                    options: const GroupButtonOptions(
                      groupingType: GroupingType.column,
                    ),
                  );
                }),
                const Spacer(),
                InkWell(
                  onTap: () {
                    pageController.jumpToPage(4);
                    groupController.unselectAll();
                  },
                  child: Container(
                    height: 3.w,
                    width: 3.w,
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: pageIndex == 4
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Iconify(
                      Majesticons.dashboard_line,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return CustomDialog(
                          title: 'Are you sure',
                          cancelTitle: 'Back',
                          successTitle: 'Logout',
                          onTap: () {
                            context.read<AuthCubit>().logOut(
                                  uid: globalSharedPreferences
                                          ?.getString('uid') ??
                                      '',
                                  logUid: globalSharedPreferences
                                          ?.getString('logUid') ??
                                      '',
                                );
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          content: 'You are going to logout.',
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 3.w,
                    width: 3.w,
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const MainHeader(),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (val) {
                      setState(() {});
                      pageIndex = val;
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //*1
                      ReceivedTab(
                        searchProductController: searchProductController,
                      ),
                      //*2
                      WashInProgressTab(
                        searchProductController: searchProductController,
                      ),
                      //*3
                      ReadyToDeliverTab(
                        searchProductController: searchProductController,
                      ),
                      //*4
                      const CheckoutTab(),
                      //*5
                      const Darshboard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
