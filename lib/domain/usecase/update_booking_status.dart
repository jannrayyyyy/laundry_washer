// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:laundry_washer/core/error/failure.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

class UpdateBookingStatus {
  final Repository repo;
  UpdateBookingStatus({required this.repo});
  Future<Either<Failure, void>> call(List<String> uid, int status) async {
    return await repo.updateBookingStatus(uid, status);
  }
}
