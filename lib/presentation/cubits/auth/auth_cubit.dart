// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/service/print.dart';

import 'package:laundry_washer/domain/usecase/login.dart';
import 'package:laundry_washer/domain/usecase/user_check.dart';

import '../../../domain/entity/group_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._userCheck,
    this._logIn,
  ) : super(AuthInitial());

  final UserCheck _userCheck;
  final LogIn _logIn;

  void userCheck() async {
    final isloggedIn = await _userCheck();
    if (isloggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  void logIn({required GroupEntity group}) async {
    final eitherLorR = await _logIn(group: group);
    eitherLorR.fold((l) => emit(Error()), (r) => show('logged in'));
  }
}
