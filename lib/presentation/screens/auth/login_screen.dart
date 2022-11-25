import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:laundry_washer/presentation/screens/auth/group_picking_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../dependency.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/custom/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final groupSelectionController = TextEditingController();
  final passwordController = TextEditingController();

  List<String> mockGroups = [
    'Group A',
    'Group B',
    'Group C',
    'Group D',
  ];
  String selectedGroup = 'Group A';
  late GroupEntity group;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // show('height pixel size: ${MediaQuery.of(context).size.height}');
    // show('width pixel size: ${MediaQuery.of(context).size.width}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image/tl_bubble.png',
                    height: 25.h,
                  ),
                  Image.asset(
                    'assets/image/tr_bubble.png',
                    height: 20.h,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/image/bl_bubble.png',
                    height: 15.h,
                  ),
                  Image.asset(
                    'assets/image/br_bubble.png',
                    height: 30.h,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  height: 60.h,
                  width: 60.h,
                ),
                Container(
                  height: 70.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        offset: const Offset(1, 4),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/image/text_logo.png',
                          height: 15.h,
                        ),
                      ),
                      CustomText(
                        'Login  to continue',
                        size: 12.sp,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: () async {
                          GroupEntity? group = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                create: (context) => sl<GroupCubit>(),
                                child: const GroupPickingScreen(),
                              ),
                            ),
                          );
                          if (mounted) {
                            if (group != null) {
                              show('meron');
                              setState(() {});
                              this.group = group;
                              groupSelectionController.text =
                                  this.group.groupName;
                            }
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: CustomTextField(
                            'Select Group',
                            controller: groupSelectionController,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).colorScheme.background,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: DropdownButton(
                      //     underline: const SizedBox(),
                      //     isExpanded: true,
                      //     hint: const CustomText('Select Group'),
                      //     // value: initialValue,
                      //     value: selectedGroup,
                      //     items: mockGroups.map((e) {
                      //       return DropdownMenuItem(
                      //         value: e,
                      //         child: CustomText(e),
                      //       );
                      //     }).toList(),
                      //     onChanged: (group) {
                      //       setState(() {});
                      //       selectedGroup = group!;
                      //     },
                      //     icon: const Iconify(
                      //       MaterialSymbols.keyboard_arrow_down_rounded,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 2.h),
                      CustomTextField(
                        'Password',
                        controller: passwordController,
                        bgColor: Theme.of(context).colorScheme.background,
                        height: 55,
                        color: Theme.of(context).primaryColor,
                        errorColor: Theme.of(context).colorScheme.error,
                      ),
                      SizedBox(height: 2.h),
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is GroupLoading) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          }
                        },
                        child: CustomButton(
                          text: 'Sign In',
                          radius: 8,
                          ontap: () {
                            if (passwordController.text == group.password) {
                              context.read<AuthCubit>().logIn(group: group);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return BlocProvider(
                              //         create: (context) => sl<GroupCubit>(),
                              //         child: const MainScreen(),
                              //       );
                              //     },
                              //   ),
                              // );
                            } else {
                              show('mali');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: CustomText('Invalid Password'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      //*divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                              ),
                              text: 'Powered by ',
                              children: [
                                TextSpan(
                                  text: 'WashUp',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      BtnTextOnly(
                        onTap: () {},
                        text: 'Forgot Password?',
                        height: 55,
                      ),
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
