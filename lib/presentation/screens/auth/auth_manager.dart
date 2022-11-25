import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/presentation/cubits/auth/auth_cubit.dart';
import 'package:laundry_washer/presentation/screens/auth/login_screen.dart';
import 'package:laundry_washer/presentation/screens/main/main_screen.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const MainScreen();
        } else if (state is UnAuthenticated) {
          return const LoginScreen();
        } else if (state is Authenticating) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
