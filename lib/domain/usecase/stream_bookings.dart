// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class StreamBookings {
  final Repository repo;
  StreamBookings({required this.repo});
  Stream<List<BookingEntity>> call() {
    return repo.streamBookings();
  }
}
