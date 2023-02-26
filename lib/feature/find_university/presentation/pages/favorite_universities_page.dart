import 'package:find_university/feature/find_university/presentation/bloc/favorite_universities_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../injection_container.dart';
import '../../data/models/university_model.dart';
import '../../data/repositories/favorite_universities_usecase.dart';

class FavoriteUniversitiesPage extends StatefulWidget {
  const FavoriteUniversitiesPage({super.key});

  @override
  State<FavoriteUniversitiesPage> createState() => _FavoriteUniversitiesPageState();
}

class _FavoriteUniversitiesPageState extends State<FavoriteUniversitiesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteUniversitiesBloc>(
      create: (context) => FavoriteUniversitiesBloc(
        favoritesUseCase: sl<FavoriteUniversitiesUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorite Universities"),
        ),
        body: BlocBuilder<FavoriteUniversitiesBloc, FavoriteUniversitiesState>(
          builder: (context, state) {
            if (state is Initial) {
              context.read<FavoriteUniversitiesBloc>().add(
                    GetFavoriteUniversitiesEvent(),
                  );
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is Loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is Loaded) {
              return ListView.builder(
                itemCount: state.favoriteUniversities.length,
                itemBuilder: (context, index) {
                  var university = state.favoriteUniversities[index];
                  return FavoriteUniversityCard(university: university);
                },
              );
            } else {
              return ErrorWidget(state as Exception);
            }
          },
        ),
      ),
    );
  }
}

class FavoriteUniversityCard extends StatelessWidget {
  const FavoriteUniversityCard({
    super.key,
    required this.university,
  });

  final UniversityModel university;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[100],
      ),
      child: Column(
        children: [
          Text(
            university.name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(CupertinoIcons.globe),
            onPressed: () async {
              await launchUrlString(
                university.webPages[0],
                mode: LaunchMode.externalApplication,
              );
            },
            label: const Text("Open"),
          ),
        ],
      ),
    );
  }
}
