// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'favorite_universities_bloc.dart';

abstract class FavoriteUniversitiesState extends Equatable {
  const FavoriteUniversitiesState();

  @override
  List<Object> get props => [];
}

class Initial extends FavoriteUniversitiesState {}

class Loading extends FavoriteUniversitiesState {}

class Loaded extends FavoriteUniversitiesState {
  List<UniversityModel> favoriteUniversities;
  Loaded({
    required this.favoriteUniversities,
  });
}

class Error extends FavoriteUniversitiesState {
  String errorMessage;
  Error({
    required this.errorMessage,
  });
}
