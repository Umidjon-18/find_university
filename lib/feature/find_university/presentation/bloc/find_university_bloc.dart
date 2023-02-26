// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:find_university/core/error/failure.dart';
import 'package:find_university/feature/find_university/data/models/university_model.dart';
import 'package:find_university/feature/find_university/data/repositories/favorite_universities_usecase.dart';
import 'package:find_university/feature/find_university/domain/usecases/find_university_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'find_university_event.dart';
part 'find_university_state.dart';

String NETWORK_EXCEPTION_OCCURED = "Nerwork exception occured";
String CACHE_EXCEPTION_OCCURED = "Cache exception occured";

class FindUniversityBloc extends Bloc<FindUniversityEvent, FindUniversityState> {
  final FindUniversityUseCase findUniversityUseCase;
  final FavoriteUniversitiesUseCase favoriteUniversitiesUseCase;
  FindUniversityBloc({
    required this.findUniversityUseCase,
    required this.favoriteUniversitiesUseCase,
  }) : super(Initial()) {
    on<GetUniversity>((event, emit) async {
      emit(Loading());
      var getUniversities = await findUniversityUseCase(Params(countryName: event.countryName));
      getUniversities.fold(
        (failure) => emit(Error(errorMessage: _mapExceptions(failure))),
        (success) => emit(Loaded(universitiesList: success)),
      );
    });
    on<SaveToFavoriteUniversities>((event, emit) async {
      await favoriteUniversitiesUseCase.saveToFavorites(event.universityModel);
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Text("Saved to Favorites"),
        ),
      );
    });
  }

  String _mapExceptions(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return NETWORK_EXCEPTION_OCCURED;
      case CacheFailure:
        return CACHE_EXCEPTION_OCCURED;
      default:
        return "Unexpected exception occured";
    }
  }
}
