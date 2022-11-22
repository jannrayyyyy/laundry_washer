import 'package:laundry_washer/data/model/group_model.dart';

abstract class RemoteDataSource {
  Future<List<GroupModel>> fetchGroups();
  Future<void> logIn({required GroupModel group});
}
