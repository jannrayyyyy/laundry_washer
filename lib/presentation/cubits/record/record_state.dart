// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'record_cubit.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitial extends RecordState {}

class RecordLoaded extends RecordState {
  final List<BookingEntity> bookings;
  const RecordLoaded({
    required this.bookings,
  });
  @override
  List<Object> get props => [bookings];
}

class RecordLoading extends RecordState {}

class RecordEmpty extends RecordState {}
