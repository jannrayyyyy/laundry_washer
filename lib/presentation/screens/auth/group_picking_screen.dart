import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/components/group_container.dart';

class GroupPickingScreen extends StatefulWidget {
  const GroupPickingScreen({super.key});

  @override
  State<GroupPickingScreen> createState() => _GroupPickingScreenState();
}

class _GroupPickingScreenState extends State<GroupPickingScreen> {
  final searchController = TextEditingController();

  List<String> mockImages = [
    'assets/image/person1.jpeg',
    'assets/image/person2.jpeg',
    'assets/image/person3.jpeg',
    'assets/image/person4.jpeg',
    'assets/image/person5.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    context.read<GroupCubit>().fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    'Search your team',
                    controller: searchController,
                    prefix: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    bgColor: Theme.of(context).colorScheme.background,
                    height: 55,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 50.w),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SvgPicture.asset('assets/svg/notif.svg'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            CustomText(
              'Select Your Team',
              size: 14.sp,
              weight: FontWeight.w600,
            ),
            SizedBox(height: 2.h),
            BlocBuilder<GroupCubit, GroupState>(
              builder: (context, state) {
                if (state is GroupLoaded) {
                  show('group loaded');
                  return Wrap(
                      spacing: 5.w,
                      runSpacing: 5.h,
                      children: state.groups
                          .map(
                            (e) => GroupContainer(
                              images: mockImages,
                            ),
                          )
                          .toList());
                } else if (state is GroupLoading) {
                  show('group loading');
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GroupError) {
                  show('group error');
                  return const Center(
                    child: CustomText('ERRORITY'),
                  );
                }
                show('group default');
                return const SizedBox();
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                'Please Select Your Team in order to Proceed',
                size: 12.sp,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
