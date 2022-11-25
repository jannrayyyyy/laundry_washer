// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/entity/rider_entity.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class FetchRider {
  final Repository repo;
  FetchRider({
    required this.repo,
  });

  Future<RiderEntity> call({required String riderId}) async {
    return await repo.fetchRider(riderId: riderId);
  }
}
