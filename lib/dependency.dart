import 'package:get_it/get_it.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource_impl.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource.dart';
import 'package:laundry_washer/data/datasource/remote/remote_datasource_impl.dart';
import 'package:laundry_washer/data/repository_impl/repository_impl.dart';
import 'package:laundry_washer/domain/repository/repository.dart';
import 'package:laundry_washer/domain/usecase/change_rider.dart';
import 'package:laundry_washer/domain/usecase/fetch_mygroup.dart';
import 'package:laundry_washer/domain/usecase/fetch_records.dart';
import 'package:laundry_washer/domain/usecase/fetch_rider.dart';
import 'package:laundry_washer/domain/usecase/fetch_todays_bookings.dart';
import 'package:laundry_washer/domain/usecase/stream_bookings.dart';
import 'package:laundry_washer/domain/usecase/fetch_groups.dart';
import 'package:laundry_washer/domain/usecase/login.dart';
import 'package:laundry_washer/domain/usecase/logout.dart';
import 'package:laundry_washer/domain/usecase/stream_riders.dart';
import 'package:laundry_washer/domain/usecase/update_booking_status.dart';
import 'package:laundry_washer/domain/usecase/user_check.dart';
import 'package:laundry_washer/presentation/cubits/auth/auth_cubit.dart';
import 'package:laundry_washer/presentation/cubits/bookings/bookings_cubit.dart';
import 'package:laundry_washer/presentation/cubits/group/group_cubit.dart';
import 'package:laundry_washer/presentation/cubits/record/record_cubit.dart';
import 'package:laundry_washer/presentation/cubits/rider/rider_cubit.dart';
import 'package:laundry_washer/presentation/cubits/today_booking/today_booking_cubit.dart';

final sl = GetIt.instance;

Future init() async {
  //*state management
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => GroupCubit(sl(), sl()));
  sl.registerFactory(() => BookingCubit(sl(), sl(), sl()));
  sl.registerFactory(() => TodayBookingCubit(sl()));
  sl.registerFactory(() => RecordCubit(sl()));
  sl.registerFactory(() => RiderCubit(sl(), sl()));
  //
  //
  //
  //
  //*usecases
  sl.registerLazySingleton(() => FetchGroups(repo: sl()));
  sl.registerLazySingleton(() => LogIn(repo: sl()));
  sl.registerLazySingleton(() => UserCheck(repo: sl()));
  sl.registerLazySingleton(() => StreamBookings(repo: sl()));
  sl.registerLazySingleton(() => UpdateBookingStatus(repo: sl()));
  sl.registerLazySingleton(() => Logout(repo: sl()));
  sl.registerLazySingleton(() => FetchTodaysBookings(repo: sl()));
  sl.registerLazySingleton(() => FetchRecords(repo: sl()));
  sl.registerLazySingleton(() => StreamRiders(repo: sl()));
  sl.registerLazySingleton(() => ChangeRider(repo: sl()));
  sl.registerLazySingleton(() => FetchMyGroup(repo: sl()));
  sl.registerLazySingleton(() => FetchRider(repo: sl()));
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
