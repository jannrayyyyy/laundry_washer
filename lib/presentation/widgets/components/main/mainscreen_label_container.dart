import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../custom/custom_datatable_label.dart';

class MainScreenLabelContainer extends StatelessWidget {
  const MainScreenLabelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      height: 6.h,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          CustomDataTableLabel(
            label: 'CATEGORY',
          ),
          CustomDataTableLabel(
            label: 'KG',
          ),
          CustomDataTableLabel(
            label: 'LOADS',
          ),
          CustomDataTableLabel(
            label: 'SCHEDULE TYPE',
          ),
          CustomDataTableLabel(
            label: 'SELECTED',
          ),
        ],
      ),
    );
  }
}
