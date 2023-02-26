part of 'favorite_universities_bloc.dart';

abstract class FavoriteUniversitiesEvent extends Equatable {
  const FavoriteUniversitiesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteUniversitiesEvent extends FavoriteUniversitiesEvent {
  
}


