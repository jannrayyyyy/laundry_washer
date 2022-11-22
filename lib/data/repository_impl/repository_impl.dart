// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:laundry_washer/core/error/failure.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/model/group_model.dart';
import 'package:laundry_washer/domain/entity/group_entity.dart';
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
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, void>> logIn({required GroupEntity group}) async {
    try {
      await remote.logIn(group: GroupModel.fromEntity(group));
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<bool> userCheck() async {
    return await local.userCheck();
  }
}
