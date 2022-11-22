import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry_washer/core/constant/strings.dart';
import 'package:laundry_washer/dependency.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/firebase_options.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:laundry_washer/presentation/screens/auth/group_picking_screen.dart';
import 'package:laundry_washer/presentation/screens/auth/login_screen.dart';
import 'package:laundry_washer/presentation/screens/main/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'presentation/cubits/auth/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return LoginScreen(
              group: state.extra != null ? state.extra as GroupEntity : null,
            );
          },
        ),
        GoRoute(
          path: '/gp_screen',
          builder: (context, state) {
            return const GroupPickingScreen();
          },
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) {
            return const MainScreen();
          },
        ),
      ],
    );
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AuthCubit>()..userCheck(),
            ),
            BlocProvider(
              create: (context) => sl<GroupCubit>(),
            ),
          ],
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.go('/main');
              } else if (state is UnAuthenticated) {
                context.go('/');
              }
            },
            child: MaterialApp.router(
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
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
            ),
          ),
        );
      },
    );
  }
}
