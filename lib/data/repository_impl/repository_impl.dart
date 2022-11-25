// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:general/general.dart';

import 'package:laundry_washer/core/error/failure.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/model/group_model.dart';
import 'package:laundry_washer/domain/entity/booking_entity.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
import 'package:laundry_washer/domain/entity/rider_entity.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remote;
  final LocalDataSource local;
  RepositoryImpl({
    required this.remote,
    required this.local,
  });
  @override
  Future<Either<Failure, List<GroupEntity>>> fetchGroups() async {
    try {
      final result = await remote.fetchGroups();
      return Right(result);
    } catch (e) {
      show('ERROR1: $e');
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, void>> logIn({required GroupEntity group}) async {
    try {
      await remote.logIn(group: GroupModel.fromEntity(group));
      return const Right(null);
    } catch (e) {
      show('ERROR2: $e');
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<bool> userCheck() async {
    return await local.userCheck();
  }

  @override
  Stream<List<BookingEntity>> streamBookings() {
    return remote.streamBookings();
  }

  @override
  Future<Either<Failure, void>> updateBookingStatus(
    List<String> uid,
    int status,
  ) async {
    try {
      final result = remote.updateBookingStatus(uid, status);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<void> logOut({required String uid, required String logUid}) async {
    try {
      await remote.logOut(uid: uid, logUid: logUid);
    } catch (e) {
      show('ERROR FOUND: $e');
    }
  }

  @override
  Stream<List<BookingEntity>> streamTodaysBookings() {
    try {
      return remote.streamTodaysBookings();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookingEntity>> fetchRecords({required int limit}) async {
    try {
      return await remote.fetchRecords(limit: limit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeRider({
    required String uid,
    required String riderUid,
  }) async {
    try {
      return await remote.changeRider(uid, riderUid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<RiderEntity>> streamRiders() {
    return remote.streamRiders();
  }

  @override
  Future<GroupEntity> fetchMyGroup({required String uid}) async {
    try {
      return await remote.fetchMyGroup(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RiderEntity> fetchRider({required String riderId}) async {
    try {
      return await remote.fetchRider(riderId: riderId);
    } catch (e) {
      rethrow;
    }
  }
}
