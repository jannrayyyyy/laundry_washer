import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/usecase/fetch_todays_bookings.dart';

part 'today_booking_state.dart';

class TodayBookingCubit extends Cubit<TodayBookingState> {
  TodayBookingCubit(this._fetchTodaysBookings) : super(TodayBookingInitial());

  final FetchTodaysBookings _fetchTodaysBookings;

  void fetchTodaysBookings() async {
    emit(TodayBookingLoading());
    final bookings = _fetchTodaysBookings();
    bookings.listen((event) {
      if (event.isEmpty) {
        emit(TodayBookingEmpty());
      } else {
        emit(TodayBookingLoading());
        emit(TodayBookingLoaded(bookings: event));
      }
    });
  }
}
