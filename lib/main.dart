import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/core/constant/strings.dart';
import 'package:laundry_washer/dependency.dart';
import 'package:laundry_washer/firebase_options.dart';
import 'package:laundry_washer/presentation/cubits/auth/auth_cubit.dart';
import 'package:laundry_washer/presentation/cubits/bookings/bookings_cubit.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:laundry_washer/presentation/cubits/record/record_cubit.dart';
import 'package:laundry_washer/presentation/cubits/rider/rider_cubit.dart';
import 'package:laundry_washer/presentation/cubits/today_booking/today_booking_cubit.dart';
import 'package:laundry_washer/presentation/screens/auth/auth_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalSharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  globalSharedPreferences = await SharedPreferences.getInstance();
  // final today = CustomFunction.getDateToday();
  // show('start: ${today['start']}');
  // show('end: ${today['end']}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Washer',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: kPrimaryColor,
            colorScheme: const ColorScheme.light(
              background: kSecondaryColorLightGrey,
              secondary: kSecondaryColorYellow,
              tertiary: kSecondaryColorGrey,
              onBackground: kBgLightBlue,
              error: kErrorColor,
              onSecondary: kSecondaryColorSemiGrey,
            ),
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<AuthCubit>()..userCheck(),
              ),
              BlocProvider(
                create: (context) => sl<GroupCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<BookingCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<TodayBookingCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<RecordCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<RiderCubit>()..streamRiders(),
              ),
            ],
            child: const AuthManager(),
          ),
        );
      },
    );
  }
}
