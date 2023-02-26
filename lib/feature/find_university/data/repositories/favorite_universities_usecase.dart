import 'package:find_university/core/error/exception.dart';
import 'package:find_university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:find_university/core/usecases/usecase.dart';
import 'package:find_university/feature/find_university/data/datasources/local/loca_datasource.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';

class FavoriteUniversitiesUseCase implements UseCase<List<UniversityModel>, NoParams> {
  final LocalFindUniversityDataSource localDataSource;

  FavoriteUniversitiesUseCase({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<UniversityModel>>> call(NoParams params) async {
    try {
      List<UniversityModel> favoriteUniversities = await localDataSource.getFavoriteUniversitiesData();
      return Right(favoriteUniversities);
    } on Exception {
      return Left(CacheFailure());
    }
  }
  Future<void> saveToFavorites(UniversityModel model) async {
    try {
      localDataSource.setFavoriteUniversitiesData(model);
    } on Exception {
      throw CacheException();
    }
  }
}

class NoParams {}
