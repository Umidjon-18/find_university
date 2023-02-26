// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:find_university/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:find_university/feature/find_university/data/models/university_model.dart';

abstract class LocalFindUniversityDataSource {
  Future<List<UniversityModel>> getCachedUniversitiesData(String countryName);
  Future<void> setCachedUniversitiesData(String countryName, List<UniversityModel> list);
  Future<List<UniversityModel>> getFavoriteUniversitiesData();
  Future<void> setFavoriteUniversitiesData(UniversityModel model);
}

class LocalFindUniversityDataSourceImpl implements LocalFindUniversityDataSource {
  SharedPreferences preferences;
  LocalFindUniversityDataSourceImpl({
    required this.preferences,
  });
  @override
  Future<List<UniversityModel>> getCachedUniversitiesData(String countryName) async {
    var universitiesStringList = preferences.get(countryName);
    if (universitiesStringList != null) {
      List<UniversityModel> universitiesList = (universitiesStringList as List<String>)
          .map(
            (e) => UniversityModel.fromJson(jsonDecode(e)),
          )
          .toList();
      return Future.value(universitiesList);
    }
    throw CacheException();
  }

  @override
  Future<void> setCachedUniversitiesData(String countryName, List<UniversityModel> list) async {
    if (!preferences.containsKey(countryName)) {
      List<String> universityListToString = list.map((e) => jsonEncode(e.toJson())).toList();
      preferences.setStringList(countryName, universityListToString);
    }
  }

  @override
  Future<List<UniversityModel>> getFavoriteUniversitiesData() {
    var universitiesStringList = preferences.get("favorites");
    if (universitiesStringList != null) {
      List<UniversityModel> universitiesList = (universitiesStringList as List<String>)
          .map(
            (e) => UniversityModel.fromJson(jsonDecode(e)),
          )
          .toList();
      return Future.value(universitiesList);
    }
    throw CacheException();
  }

  @override
  Future<void> setFavoriteUniversitiesData(UniversityModel model) async {
    String encodedModel = jsonEncode(model.toJson());
    List<String> favorites = preferences.getStringList("favorites") ?? [];
    if (!favorites.contains(encodedModel)) {
      favorites.add(encodedModel);
      preferences.setStringList("favorites", favorites);
    }
  }
}
