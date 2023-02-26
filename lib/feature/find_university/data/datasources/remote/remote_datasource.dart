import 'package:dio/dio.dart';
import 'package:find_university/core/error/exception.dart';
import 'package:find_university/feature/find_university/data/datasources/local/loca_datasource.dart';

import 'package:find_university/feature/find_university/data/models/university_model.dart';

abstract class RemoteFindUniversityDataSource {
  Future<List<UniversityModel>> fetchUniversitiesData(String countryName);
}

class RemoteFindUniversityDataSourceImpl implements RemoteFindUniversityDataSource {
  final Dio dio;
  final LocalFindUniversityDataSource localDataSource;
  RemoteFindUniversityDataSourceImpl({
    required this.localDataSource,
    required this.dio,
  });

  @override
  Future<List<UniversityModel>> fetchUniversitiesData(String countryName) async {
    var response = await dio.get(
      "http://universities.hipolabs.com/search?country=$countryName",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      List<UniversityModel> universityList = [];
      for (var element in (response.data as List)) {
        universityList.add(UniversityModel.fromJson(element));
      }
      localDataSource.setCachedUniversitiesData(countryName, universityList);
      return universityList;
    } else {
      throw ServerException();
    }
  }
}
