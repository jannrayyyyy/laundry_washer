// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_cubit.dart';

abstract class GroupState extends Equatable {}

class GroupInitial extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupLoaded extends GroupState {
  final List<GroupEntity> groups;
  GroupLoaded({
    required this.groups,
  });

  @override
  List<Object?> get props => [groups];
}

class SingleGroupLoaded extends GroupState {
  final GroupEntity group;
  SingleGroupLoaded({
    required this.group,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GroupLoading extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupError extends GroupState {
  @override
  List<Object?> get props => [];
}
