import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:laundry_washer/presentation/widgets/components/main/main_header.dart';
import 'package:laundry_washer/presentation/widgets/custom/custom_circular_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();
  final groupController = GroupButtonController();

  @override
  void initState() {
    super.initState();
    groupController.selectIndex(0);
  }

  @override
  Widget build(BuildContext context) {
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
                GroupButton(
                  controller: groupController,
                  buttons: const [
                    1,
                    2,
                    3,
                  ],
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
                ),
                const Spacer(),
                Container(
                  height: 3.w,
                  width: 3.w,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Iconify(
                    Majesticons.dashboard_line,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                MainHeader(
                  controller: searchController,
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
