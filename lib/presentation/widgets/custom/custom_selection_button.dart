import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSelectionButton extends StatelessWidget {
  final String successTitle;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final Color? successColor;
  const CustomSelectionButton({
    super.key,
    required this.successTitle,
    required this.onTap,
    required this.onClear,
    this.successColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      // height: 30.h,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF7F7F9),
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(2.h),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'PLEASE DOUBLE CHECK BEFORE\n',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                      text: 'CLICKING ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: 'WASH NOW ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      )),
                  const TextSpan(
                    text: 'BUTTON',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          BtnFilled(
            onTap: onClear,
            text: 'CLEAR ALL',
            color: Theme.of(context).colorScheme.error,
            radius: 8,
            height: 55,
          ),
          const SizedBox(height: 5),
          BtnFilled(
            onTap: onTap,
            text: successTitle,
            color: successColor ?? Theme.of(context).primaryColor,
            radius: 8,
            height: 55,
          ),
        ],
      ),
    );
  }
}
