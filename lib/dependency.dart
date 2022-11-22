import 'package:get_it/get_it.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource_impl.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource_impl.dart';
import 'package:laundry_washer/data/repository_impl/repository_impl.dart';
import 'package:laundry_washer/domain/repository/repository.dart';
import 'package:laundry_washer/domain/usecase/fetch_groups.dart';
import 'package:laundry_washer/domain/usecase/login.dart';
import 'package:laundry_washer/domain/usecase/user_check.dart';
import 'package:laundry_washer/presentation/cubits/auth/auth_cubit.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';

final sl = GetIt.instance;

Future init() async {
  //*state management
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerFactory(() => GroupCubit(sl()));
  //
  //
  //
  //
  //*usecases
  sl.registerLazySingleton(() => FetchGroups(repo: sl()));
  sl.registerLazySingleton(() => LogIn(repo: sl()));
  sl.registerLazySingleton(() => UserCheck(repo: sl()));
  //
  //
  //
  //
  //*repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(remote: sl(), local: sl()),
  );
  //
  //
  //
  //
  //*data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(local: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}
