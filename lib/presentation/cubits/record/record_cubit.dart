import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/usecase/fetch_records.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit(this._records) : super(RecordInitial());

  final FetchRecords _records;

  Future<void> fetchRecords({
    required int limit,
    bool canLoad = true,
  }) async {
    if (canLoad) {
      emit(RecordLoading());
    }
    final records = await _records(limit: limit);
    Future.delayed(const Duration(milliseconds: 120));
    if (records.isEmpty) {
      emit(RecordEmpty());
    } else {
      emit(RecordLoaded(bookings: records));
    }
  }
}
