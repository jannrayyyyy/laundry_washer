// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:laundry_washer/domain/repository/repository.dart';

import '../../core/error/failure.dart';
import '../entity/group_entity.dart';

class LogIn {
  final Repository repo;
  LogIn({
    required this.repo,
  });

  Future<Either<Failure, void>> call({required GroupEntity group}) async {
    return await repo.logIn(group: group);
  }
}
