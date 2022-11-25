import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry_washer/domain/entity/rider_entity.dart';
import 'package:laundry_washer/domain/usecase/fetch_rider.dart';
import 'package:laundry_washer/domain/usecase/stream_riders.dart';

part 'rider_state.dart';

class RiderCubit extends Cubit<RiderState> {
  RiderCubit(this._streamRiders, this._fetchRider) : super(RiderInitial());
  final StreamRiders _streamRiders;
  final FetchRider _fetchRider;

  void streamRiders() {
    emit(RiderLoading());
    final rider = _streamRiders();
    rider.listen((event) {
      emit(RiderLoading());
      if (event.isEmpty) {
        emit(RiderEmpty());
      } else {
        emit(RiderLoading());
        emit(RiderLoaded(riders: event));
      }
    });
  }

  void fetchRider({required String riderId}) async {
    emit(RiderLoading());

    final rider = await _fetchRider(riderId: riderId);
    emit(SingleRiderLoaded(rider: rider));
  }
}
