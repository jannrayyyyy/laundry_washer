// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/entity/booking_entity.dart';

import '../repository/repository.dart';

class FetchRecords {
  final Repository repo;
  FetchRecords({
    required this.repo,
  });

  Future<List<BookingEntity>> call({required int limit}) async {
    return await repo.fetchRecords(limit: limit);
  }
}
