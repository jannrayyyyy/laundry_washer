import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/domain/usecase/fetch_groups.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this._fetchGroups) : super(GroupInitial());
  final FetchGroups _fetchGroups;

  void fetchGroups() async {
    emit(GroupLoading());
    final eitherLorR = await _fetchGroups();
    eitherLorR.fold(
        (l) => emit(GroupError()), (r) => emit(GroupLoaded(groups: r)));
  }
}
