// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/repository/repository.dart';

class ChangeRider {
  final Repository repo;
  ChangeRider({required this.repo});
  Future<void> call(String uid, String riderUid) async {
    await repo.changeRider(uid: uid, riderUid: riderUid);
  }
}
