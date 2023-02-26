// ignore_for_file: must_be_immutable

part of 'find_university_bloc.dart';

@immutable
abstract class FindUniversityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends FindUniversityState {}

class Loading extends FindUniversityState {}

class Loaded extends FindUniversityState {
  List<UniversityModel> universitiesList;
  Loaded({required this.universitiesList});
  @override
  List<Object?> get props => [universitiesList];
}

class Error extends FindUniversityState {
  String errorMessage;
  Error({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
