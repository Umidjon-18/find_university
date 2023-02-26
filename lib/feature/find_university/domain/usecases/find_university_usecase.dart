// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_university/core/error/failure.dart';
import 'package:find_university/core/usecases/usecase.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';
import 'package:find_university/feature/find_university/domain/repositories/find_university_repository.dart';

import '../../../../core/util/input_formatter.dart';

class FindUniversityUseCase implements UseCase<List<UniversityModel>, Params> {
  final FindUniversityRepository findUniversityRepository;
  final InputFormatter inputFormatter;
  FindUniversityUseCase({
    required this.findUniversityRepository,
    required this.inputFormatter,
  });

  @override
  Future<Either<Failure, List<UniversityModel>>> call(Params params) async {
    return await findUniversityRepository.getUniversities(
      inputFormatter.formatCountry(params.countryName),
    );
  }
}

class Params {
  String countryName;
  Params({
    required this.countryName,
  });
}
