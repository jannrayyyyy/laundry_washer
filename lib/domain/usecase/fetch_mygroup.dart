// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../entity/group_entity.dart';
import '../repository/repository.dart';

class FetchMyGroup {
  final Repository repo;
  FetchMyGroup({
    required this.repo,
  });

  Future<GroupEntity> call({required String uid}) async {
    return await repo.fetchMyGroup(uid: uid);
  }
}
