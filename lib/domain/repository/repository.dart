import 'package:dartz/dartz.dart';
import 'package:laundry_washer/core/error/failure.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/domain/entity/rider_entity.dart';

abstract class Repository {
  Future<Either<Failure, void>> logIn({required GroupEntity group});
  Future<Either<Failure, List<GroupEntity>>> fetchGroups();
  Future<bool> userCheck();
  Stream<List<BookingEntity>> streamBookings();
  Future<Either<Failure, void>> updateBookingStatus(
    List<String> uid,
    int status,
  );
  Future<void> logOut({required String uid, required String logUid});
  Stream<List<BookingEntity>> streamTodaysBookings();
  Future<List<BookingEntity>> fetchRecords({required int limit});
  Stream<List<RiderEntity>> streamRiders();
  Future<void> changeRider({required String uid, required String riderUid});
  Future<GroupEntity> fetchMyGroup({required String uid});
  Future<RiderEntity> fetchRider({required String riderId});
}
