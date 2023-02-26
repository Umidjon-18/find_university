import 'package:find_university/feature/find_university/data/models/university_model.dart';
import 'package:find_university/feature/find_university/data/repositories/favorite_universities_usecase.dart';
import 'package:find_university/feature/find_university/presentation/bloc/find_university_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../injection_container.dart';
import '../../domain/usecases/find_university_usecase.dart';

class UniversitiesPage extends StatefulWidget {
  final String countryName;
  const UniversitiesPage({
    super.key,
    required this.countryName,
  });
  static const id = "universities_page";

  @override
  State<UniversitiesPage> createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FindUniversityBloc>(
      create: (context) => FindUniversityBloc(
        findUniversityUseCase: sl<FindUniversityUseCase>(),
        favoriteUniversitiesUseCase: sl<FavoriteUniversitiesUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.countryName),
        ),
        body: BlocBuilder<FindUniversityBloc, FindUniversityState>(
          builder: (context, state) {
            if (state is Initial) {
              context.read<FindUniversityBloc>().add(GetUniversity(
                    countryName: widget.countryName,
                  ));
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is Loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is Loaded) {
              return ListView.builder(
                itemCount: state.universitiesList.length,
                itemBuilder: (context, index) {
                  var university = state.universitiesList[index];
                  return UniversityCard(university: university);
                },
              );
            } else {
              return ErrorWidget(error: (state as Error));
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.error,
  });
  final Error error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.cube_box_fill),
          Text(
            error.errorMessage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class UniversityCard extends StatelessWidget {
  const UniversityCard({
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              ElevatedButton.icon(
                icon: const Icon(Icons.favorite),
                onPressed: () async {
                  context.read<FindUniversityBloc>().add(SaveToFavoriteUniversities(
                        context: context,
                        universityModel: university,
                      ));
                },
                label: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
