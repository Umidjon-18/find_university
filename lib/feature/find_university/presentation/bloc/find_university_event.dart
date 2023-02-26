// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'find_university_bloc.dart';

@immutable
abstract class FindUniversityEvent {}

class GetUniversity extends FindUniversityEvent {
  String countryName;
  GetUniversity({
    required this.countryName,
  });
}

class SaveToFavoriteUniversities extends FindUniversityEvent {
  UniversityModel universityModel;
  BuildContext context;
  SaveToFavoriteUniversities({
    required this.universityModel,
    required this.context,
  });
}
