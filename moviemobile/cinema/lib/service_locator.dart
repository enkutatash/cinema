import 'package:cinema/core/network/network.dart';
import 'package:cinema/features/auth/data/data_source/local_data_source.dart';
import 'package:cinema/features/auth/data/data_source/remote_data_source.dart';
import 'package:cinema/features/auth/data/repository/auth_repo_imp.dart';
import 'package:cinema/features/auth/domain/repository/auth_repo.dart';
import 'package:cinema/features/auth/domain/usecase/login_usecase.dart';
import 'package:cinema/features/auth/domain/usecase/register_usecase.dart';
import 'package:cinema/features/movie/data/data_source/remote_data_source.dart';
import 'package:cinema/features/movie/data/repository/movierepo_imp.dart';
import 'package:cinema/features/movie/domain/repository/movie_repo.dart';
import 'package:cinema/features/movie/domain/usecase/movie_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;
Future<void> setUp() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Register NetworkInfo with NetworkInfoImpl
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImple(
        connectionChecker: locator<InternetConnectionChecker>()),
  );
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImp(sharedPreferences: locator<SharedPreferences>()),
  );
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(dio: locator<Dio>()));
  locator.registerLazySingleton<AuthRepo>(() => AuthRepoImp(
      remoteDataSource: locator<RemoteDataSource>(),
      localDataSource: locator<LocalDataSource>(),
      networkInfo: locator<NetworkInfo>()));
  locator.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(authRepo: locator<AuthRepo>()));
  locator.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(authRepo: locator<AuthRepo>()));
  locator.registerLazySingleton<RemoveDataSourceMovie>(()=> RemoveDataSourceMovie(dio: locator<Dio>()));
  locator.registerLazySingleton<MovieRepo>(() => MovierepoImp(remoteDataSource: locator<RemoveDataSourceMovie>(), networkInfo: locator<NetworkInfo>()));
  locator.registerLazySingleton<GetMoviesUsecase>(()=>GetMoviesUsecase(movieRepository: locator<MovieRepo>()));
    locator.registerLazySingleton<GetMovieScheduleUsecase>(()=>GetMovieScheduleUsecase(movieRepository: locator<MovieRepo>()));
}
