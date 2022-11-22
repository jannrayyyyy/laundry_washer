// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupEntity {
  final String groupName;
  final List<String> members;
  final String password;
  final int shift;
  final String uid;
  GroupEntity({
    required this.groupName,
    required this.members,
    required this.password,
    required this.shift,
    required this.uid,
  });
}
