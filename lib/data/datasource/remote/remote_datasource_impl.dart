// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:general/service/print.dart';

import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/model/booking_model.dart';
import 'package:laundry_washer/data/model/group_model.dart';
import 'package:laundry_washer/data/model/rider_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final db = FirebaseFirestore.instance;
  final LocalDataSource local;
  RemoteDataSourceImpl({
    required this.local,
  });
  @override
  Future<List<GroupModel>> fetchGroups() async {
    final groupsRef = db.collection('group');
    final querySnap = await groupsRef.get();
    final groups = querySnap.docs.map((e) {
      show('groupname: ${e['groupName']}');
      return GroupModel.fromMap(e.data());
    }).toList();
    show('group length: ${groups.length}');
    return groups;
  }

  @override
  Future<void> logIn({required GroupModel group}) async {
    final logs = db.collection('group').doc(group.uid).collection('logs').doc();
    await logs.set({
      'uid': logs.id,
      'createdAt': DateTime.now().toString(),
      'type': 1,
      'createdBy': group.uid,
    }).then((value) async {
      await local.storeUid(uid: group.uid, logUid: logs.id);
    });
  }

  @override
  Stream<List<BookingModel>> streamBookings() {
    return db
        .collection('bookings')
        .where('bookingStatus', whereIn: [2, 3, 4, 5, 6])
        // .where('hub', isEqualTo: 'hub')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BookingModel.fromMap(e.data())).toList());
  }

  @override
  Future<void> updateBookingStatus(List<String> uids, int status) async {
    show('clicked');
    uids.forEach((uid) async {
      final statusRef = db.collection('bookings').doc(uid);
      show('data: $statusRef');
      await statusRef.update({'bookingStatus': status});
    });
  }

  @override
  Future<void> logOut({required String uid, required String logUid}) async {
    await local.removeUid().then((value) async {
      final logRef =
          db.collection('group').doc(uid).collection('logs').doc(logUid);
      await logRef.update({'type': 0});
    });
  }

  @override
  Stream<List<BookingModel>> streamTodaysBookings() {
    return db
        .collection('bookings')
        // .where('createdAt', isGreaterThan: today['start'])
        // .where('createdAt', isLessThan: today['end'])
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BookingModel.fromMap(e.data())).toList());
  }

  @override
  Future<List<BookingModel>> fetchRecords({required int limit}) async {
    final bookingsRef = db.collection('bookings');
    final querySnap = await bookingsRef
        .where('bookingStatus', whereIn: [2, 3, 4, 5, 6])
        .limit(limit)
        .get();
    final bookings = querySnap.docs.map((e) {
      return BookingModel.fromMap(e.data());
    }).toList();
    return bookings;
  }

  @override
  Future<void> changeRider(String uid, String riderUid) async {
    final rider =
        db.collection('bookings').doc(uid).update({'riderId': riderUid});
    await rider;
  }

  @override
  Stream<List<RiderModel>> streamRiders() {
    return db
        .collection('rider')
        // .where('hub', isEqualTo: 'hub')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RiderModel.fromMap(e.data())).toList());
  }

  @override
  Future<GroupModel> fetchMyGroup({required String uid}) async {
    final groupRef = await db.collection('group').doc(uid).get();
    return GroupModel.fromMap(groupRef.data()!);
  }

  @override
  Future<RiderModel> fetchRider({required String riderId}) async {
    final riderRef = await db.collection('rider').doc(riderId).get();
    return RiderModel.fromMap(riderRef.data()!);
  }
}
