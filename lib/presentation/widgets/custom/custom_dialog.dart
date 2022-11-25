import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelTitle;
  final String successTitle;
  final Function() onTap;
  final double? titleSize;
  final double? contentSize;
  const CustomDialog({
    super.key,
    required this.title,
    required this.cancelTitle,
    required this.successTitle,
    required this.onTap,
    required this.content,
    this.titleSize,
    this.contentSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Dialog(
            child: Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Expanded(
                      child: Column(
                        children: [
                          CustomText(
                            title,
                            size: titleSize ?? 18.sp,
                            color: Colors.black,
                            weight: FontWeight.w800,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            content,
                            size: contentSize ?? 12.sp,
                            weight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onTertiary,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BtnFilled(
                            onTap: () => Navigator.pop(context),
                            width: 15.w,
                            radius: 14,
                            text: cancelTitle,
                            color: Theme.of(context).colorScheme.onBackground,
                            text_color: Colors.black,
                          ),
                          BtnFilled(
                            onTap: onTap,
                            width: 15.w,
                            radius: 14,
                            text: successTitle,
                            color: Theme.of(context).primaryColor,
                            text_color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 30.h,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              'assets/image/questionmark.png',
              height: 60,
            ),
          ),
        ),
      ],
    );
  }
}
