// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookings_cubit.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object> get props => [];
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingEntity> bookings;
  const BookingsLoaded({required this.bookings});
}

class BookingsEmpty extends BookingsState {}

class BookingsError extends BookingsState {
  final String msg;
  const BookingsError({required this.msg});
}

class CheckOutDone extends BookingsState {}

class CheckOutLoading extends BookingsState {}
