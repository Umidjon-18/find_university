import 'package:dio/dio.dart';
import 'package:find_university/core/network/network_info.dart';
import 'package:find_university/core/util/input_formatter.dart';
import 'package:find_university/feature/find_university/data/datasources/local/loca_datasource.dart';
import 'package:find_university/feature/find_university/data/datasources/remote/remote_datasource.dart';
import 'package:find_university/feature/find_university/data/repositories/find_university_repository_impl.dart';
import 'package:find_university/feature/find_university/domain/usecases/find_university_usecase.dart';
import 'package:find_university/feature/find_university/presentation/bloc/find_university_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/find_university/data/repositories/favorite_universities_usecase.dart';
import 'feature/find_university/domain/repositories/find_university_repository.dart';
import 'feature/find_university/presentation/bloc/favorite_universities_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Find University
  // * Blocs
  sl.registerFactory(() => FindUniversityBloc(findUniversityUseCase: sl(), favoriteUniversitiesUseCase: sl()));
  sl.registerFactory(() => FavoriteUniversitiesBloc(favoritesUseCase: sl()));

  // * Use Cases
  sl.registerLazySingleton(
    () => FindUniversityUseCase(
      findUniversityRepository: sl(),
      inputFormatter: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => FavoriteUniversitiesUseCase(localDataSource: sl()),
  );

  // * Repositories
  sl.registerLazySingleton<FindUniversityRepository>(() => FindUniversityRepositoryImpl(
        localFindUniversityDataSource: sl(),
        remoteFindUniversityDataSource: sl(),
        networkInfo: sl(),
      ));

  // * DataSources
  sl.registerLazySingleton<RemoteFindUniversityDataSource>(() => RemoteFindUniversityDataSourceImpl(
        localDataSource: sl(),
        dio: sl(),
      ));

  sl.registerLazySingleton<LocalFindUniversityDataSource>(() => LocalFindUniversityDataSourceImpl(preferences: sl()));

  // ! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InputFormatter());

  // ! External
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker();

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => internetConnectionChecker);
}
