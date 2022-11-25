// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:laundry_washer/domain/entity/rider_entity.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class StreamRiders {
  final Repository repo;
  StreamRiders({required this.repo});
  Stream<List<RiderEntity>> call() {
    return repo.streamRiders();
  }
}
