import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/usecase/change_rider.dart';
import 'package:laundry_washer/domain/usecase/stream_bookings.dart';
import 'package:laundry_washer/domain/usecase/update_booking_status.dart';

part 'bookings_state.dart';

class BookingCubit extends Cubit<BookingsState> {
  BookingCubit(
    this._streamBookings,
    this._updateBookingStatus,
    this._changeRider,
  ) : super(BookingsInitial());
  final StreamBookings _streamBookings;
  final UpdateBookingStatus _updateBookingStatus;
  final ChangeRider _changeRider;

  void streamBookings() {
    emit(BookingsLoading());
    final bookings = _streamBookings();
    bookings.listen((event) {
      if (event.isEmpty) {
        emit(BookingsEmpty());
      } else {
        emit(BookingsLoading());
        emit(BookingsLoaded(bookings: event));
      }
    });
  }

  Future<void> updateBookingStatus(List<String> uid, int status) async {
    final bookingStatus = await _updateBookingStatus(uid, status);
    bookingStatus.fold((l) => emit(BookingsError(msg: l.message)), (r) {});
  }

  Future<void> changeRider({
    required String uid,
    required String riderUid,
    required BuildContext context,
  }) async {
    emit(BookingsLoading());
    await _changeRider(uid, riderUid).then((value) {
      if (Navigator.canPop(context)) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }
}
