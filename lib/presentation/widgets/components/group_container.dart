import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/presentation/widgets/custom/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupContainer extends StatelessWidget {
  final List<String> images;
  final GroupEntity group;
  const GroupContainer({
    super.key,
    required this.images,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      width: 26.w,
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            offset: const Offset(1, 4),
            spreadRadius: 0.5,
            blurRadius: 5,
          ),
        ],
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Team A',
            size: 11.sp,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Afternoon Shift',
                size: 13.sp,
              ),
              CustomText(
                '7:00 - 12:00 PM',
                size: 11.sp,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: group.members.map((e) {
              return FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection('crew').doc(e).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final crew = snapshot.data!.data() as Map<String, dynamic>;
                    return CircleAvatar(
                      radius: 16,
                      foregroundImage: NetworkImage(
                        crew['imageLink'],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
            }).toList(),
          ),
          // FlutterImageStack(
          //   imageList: images,
          //   totalCount: 5,
          //   itemCount: 3,
          //   showTotalCount: true,
          //   imageSource: ImageSource.Asset,
          //   itemRadius: 6.h,
          //   backgroundColor: Theme.of(context).primaryColor,
          //   extraCountTextStyle: const TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   itemBorderColor: Theme.of(context).colorScheme.background,
          // ),
          const Spacer(),
          CustomButton(
            text: 'Select',
            ontap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context, group);
              }
              show('go');
              show('group: ${group.groupName}');
            },
          ),
        ],
      ),
    );
  }
}
