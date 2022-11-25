import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/core/utils/custom_function.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../../../cubits/group/group_cubit.dart';

class MainHeader extends StatelessWidget {
  final TextEditingController? controller;
  const MainHeader({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomTextField(
              'Search product or any order...',
              controller: controller,
              bgColor: Theme.of(context).colorScheme.background,
            ),
          ),
          const Spacer(flex: 3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                'GROUP A',
                weight: FontWeight.w600,
                size: 12.sp,
              ),
              CustomText(
                'DAY 2',
                weight: FontWeight.w600,
                size: 11.sp,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const Spacer(flex: 3),
          Row(
            children: const [
              Icon(Icons.calendar_today),
              CustomText(
                'October 18th 2002',
              ),
            ],
          ),
          const Spacer(flex: 1),
          BlocBuilder<GroupCubit, GroupState>(
            builder: (context, state) {
              if (state is SingleGroupLoaded) {
                show('loaded');
                final time = CustomFunction.getTimeShift(state.group.shift);
                show("time1: ${time.split('-')[0]}");
                show("time2: ${time.split('-')[1]}");
                show('day: ${DateTime.now().day}');
                return Container(
                  padding: EdgeInsets.all(1.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TimerCountdown(
                    format: CountDownTimerFormat.hoursMinutesSeconds,
                    endTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(
                        time.split('-')[1],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

// TimeOfDay(
//                                 hour = int.parse(
//                                     time.split(' - ')[0].split(':')[0]),
//                                 minute = int.parse(
//                                     time.split(' - ')[0].split(':')[1]))
//                             .format(context)