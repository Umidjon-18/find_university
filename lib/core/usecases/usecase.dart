import 'package:dartz/dartz.dart';
import 'package:find_university/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}