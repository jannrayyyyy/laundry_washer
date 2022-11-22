// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:general/service/print.dart';

import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/model/group_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final db = FirebaseFirestore.instance;
  final LocalDataSource local;
  RemoteDataSourceImpl({
    required this.local,
  });
  @override
  Future<List<GroupModel>> fetchGroups() async {
    final groupsRef = db.collection('group');
    final querySnap = await groupsRef.get();
    final groups = querySnap.docs.map((e) {
      show('groupname: ${e['groupName']}');
      return GroupModel.fromMap(e.data());
    }).toList();
    show('group lengtg: ${groups.length}');
    return groups;
  }

  @override
  Future<void> logIn({required GroupModel group}) async {
    await local.storeUid(uid: group.uid).then((value) async {
      final logs =
          db.collection('group').doc(group.uid).collection('logs').doc();
      await logs.set({
        'uid': logs.id,
        'createdAt': DateTime.now().toString(),
        'type': 1,
        'createdBy': group.uid,
      });
    });
  }
}
