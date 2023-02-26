import 'package:equatable/equatable.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';
import 'package:find_university/feature/find_university/data/repositories/favorite_universities_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_universities_event.dart';
part 'favorite_universities_state.dart';

class FavoriteUniversitiesBloc extends Bloc<FavoriteUniversitiesEvent, FavoriteUniversitiesState> {
  final FavoriteUniversitiesUseCase favoritesUseCase;
  FavoriteUniversitiesBloc({
    required this.favoritesUseCase,
  }) : super(Initial()) {
    on<GetFavoriteUniversitiesEvent>((event, emit) async {
      emit(Loading());
      final getUniversities = await favoritesUseCase(NoParams());
      getUniversities.fold(
        (l) => emit(Error(errorMessage: "Favorite List is empty")),
        (r) => emit(Loaded(favoriteUniversities: r)),
      );
    });
  }
}
