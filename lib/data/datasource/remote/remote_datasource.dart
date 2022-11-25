import 'package:laundry_washer/data/model/group_model.dart';
import 'package:laundry_washer/data/model/rider_model.dart';

import '../../model/booking_model.dart';

abstract class RemoteDataSource {
  Future<List<GroupModel>> fetchGroups();
  Future<void> logIn({required GroupModel group});
  Future<void> updateBookingStatus(List<String> uid, int status);
  Stream<List<BookingModel>> streamBookings();
  Future<void> logOut({required String uid, required String logUid});
  Stream<List<BookingModel>> streamTodaysBookings();
  Future<List<BookingModel>> fetchRecords({required int limit});
  Stream<List<RiderModel>> streamRiders();
  Future<void> changeRider(String uid, String riderUid);
  Future<GroupModel> fetchMyGroup({required String uid});
  Future<RiderModel> fetchRider({required String riderId});
}
