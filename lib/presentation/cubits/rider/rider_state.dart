// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rider_cubit.dart';

abstract class RiderState extends Equatable {
  const RiderState();

  @override
  List<Object> get props => [];
}

class RiderInitial extends RiderState {}

class RiderLoading extends RiderState {}

class RiderLoaded extends RiderState {
  final List<RiderEntity> riders;
  const RiderLoaded({
    required this.riders,
  });
}

class SingleRiderLoaded extends RiderState {
  final RiderEntity rider;
  const SingleRiderLoaded({
    required this.rider,
  });
}

class RiderEmpty extends RiderState {}

class RiderError extends RiderState {}
