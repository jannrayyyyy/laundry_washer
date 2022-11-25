// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class FetchTodaysBookings {
  final Repository repo;
  FetchTodaysBookings({
    required this.repo,
  });

  Stream<List<BookingEntity>> call() {
    return repo.streamTodaysBookings();
  }
}
