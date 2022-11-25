// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'today_booking_cubit.dart';

abstract class TodayBookingState extends Equatable {
  const TodayBookingState();

  @override
  List<Object> get props => [];
}

class TodayBookingInitial extends TodayBookingState {}

class TodayBookingLoading extends TodayBookingState {}

class TodayBookingLoaded extends TodayBookingState {
  final List<BookingEntity> bookings;
  const TodayBookingLoaded({
    required this.bookings,
  });
}

class TodayBookingEmpty extends TodayBookingState {}
