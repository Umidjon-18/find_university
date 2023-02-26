// ignore_for_file: non_constant_identifier_names

import 'package:find_university/core/error/exception.dart';
import 'package:find_university/core/network/network_info.dart';
import 'package:find_university/feature/find_university/data/datasources/local/loca_datasource.dart';
import 'package:find_university/feature/find_university/data/datasources/remote/remote_datasource.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';
import 'package:find_university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:find_university/feature/find_university/domain/repositories/find_university_repository.dart';


class FindUniversityRepositoryImpl implements FindUniversityRepository {
  final LocalFindUniversityDataSource localFindUniversityDataSource;
  final RemoteFindUniversityDataSource remoteFindUniversityDataSource;
  final NetworkInfo networkInfo;

  FindUniversityRepositoryImpl({
    required this.localFindUniversityDataSource,
    required this.remoteFindUniversityDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversities(String countryName) async {
    if (await networkInfo.hasConnection) {
      try {
        List<UniversityModel> universityList = await remoteFindUniversityDataSource.fetchUniversitiesData(countryName);
        return Right(universityList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        List<UniversityModel> universityList =
            await localFindUniversityDataSource.getCachedUniversitiesData(countryName);
        return Right(universityList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
