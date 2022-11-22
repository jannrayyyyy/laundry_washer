import 'package:laundry_washer/domain/entity/group_entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    required super.groupName,
    required super.members,
    required super.password,
    required super.shift,
    required super.uid,
  });
  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      groupName: map['groupName'],
      members: map['members'],
      password: map['password'],
      shift: map['shift'],
      uid: map['uid'],
    );
  }
  factory GroupModel.fromEntity(GroupEntity group) {
    return GroupModel(
      groupName: group.groupName,
      members: group.members,
      password: group.password,
      shift: group.shift,
      uid: group.uid,
    );
  }
}
