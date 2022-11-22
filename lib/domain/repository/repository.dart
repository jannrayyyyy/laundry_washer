import 'package:dartz/dartz.dart';
import 'package:laundry_washer/core/error/failure.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';

abstract class Repository {
  Future<Either<Failure, void>> logIn({required GroupEntity group});
  Future<Either<Failure, List<GroupEntity>>> fetchGroups();
  Future<bool> userCheck();
}
