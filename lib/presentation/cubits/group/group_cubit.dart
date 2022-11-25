import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/domain/usecase/fetch_groups.dart';
import 'package:laundry_washer/domain/usecase/fetch_mygroup.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this._fetchGroups, this._fetchMyGroup) : super(GroupInitial());
  final FetchGroups _fetchGroups;
  final FetchMyGroup _fetchMyGroup;

  void fetchGroups() async {
    emit(GroupLoading());
    final eitherLorR = await _fetchGroups();
    eitherLorR.fold(
        (l) => emit(GroupError()), (r) => emit(GroupLoaded(groups: r)));
  }

  void fetchMyGroup({required String uid}) async {
    emit(GroupLoading());
    final group = await _fetchMyGroup(uid: uid);
    if (group.uid.isNotEmpty) {
      emit(SingleGroupLoaded(group: group));
    }
  }
}
