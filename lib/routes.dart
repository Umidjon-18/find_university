import 'package:find_university/feature/find_university/presentation/pages/countries_page.dart';
import 'package:find_university/feature/find_university/presentation/pages/favorite_universities_page.dart';
import 'package:find_university/feature/find_university/presentation/pages/universities_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const CountriesPage();
      },
    ),
    GoRoute(
      path: "/universities/:countryName",
      name: "universities",
      builder: (context, state) => UniversitiesPage(
        countryName: state.params["countryName"]!,
      ),
    ),
    GoRoute(
      path: "/favoriteUniversities",
      name: "favoriteUniversities",
      builder: (context, state) => const FavoriteUniversitiesPage(),
    ),
  ],
);
