import 'package:dartz/dartz.dart';
import 'package:find_university/core/error/failure.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';

abstract class FindUniversityRepository {
  Future<Either<Failure, List<UniversityModel>>> getUniversities(String countryName);
}