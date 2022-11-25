import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../custom/custom_datatable_label.dart';

class DashboardTableHeader extends StatelessWidget {
  const DashboardTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            label: 'IDENTIFIER',
            flex: 1,
          ),
          CustomDataTableLabel(
            label: 'CATEGORY',
            flex: 2,
          ),
          CustomDataTableLabel(
            label: 'KG',
          ),
          CustomDataTableLabel(
            label: 'QTY',
          ),
          CustomDataTableLabel(
            label: 'LOAD/S',
          ),
          CustomDataTableLabel(
            label: 'SCHEDULE TYPE',
            flex: 2,
          ),
          CustomDataTableLabel(
            label: 'STATUS',
            flex: 2,
          ),
          CustomDataTableLabel(
            label: 'RECEIVED DATE',
            flex: 2,
          ),
          CustomDataTableLabel(
            label: 'COMPLETED',
            flex: 2,
          ),
        ],
      ),
    );
  }
}
