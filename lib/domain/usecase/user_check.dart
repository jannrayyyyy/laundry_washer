// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/repository/repository.dart';

class UserCheck {
  final Repository repo;
  UserCheck({
    required this.repo,
  });
  Future<bool> call() async {
    return await repo.userCheck();
  }
}
