// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/repository/repository.dart';

class Logout {
  final Repository repo;
  Logout({
    required this.repo,
  });

  Future<void> call({required String uid, required String logUid}) async {
    await repo.logOut(uid: uid, logUid: logUid);
  }
}
