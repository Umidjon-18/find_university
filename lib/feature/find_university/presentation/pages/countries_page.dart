import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});
  static const id = "countries_page";

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("World Universities"),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed("favoriteUniversities");
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: countriesList(),
    );
  }

  Widget countriesList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: countries.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: MaterialButton(
            onPressed: () {
              context.pushNamed("universities", params: {
                "countryName": countries[index]["name"],
              });
            },
            height: 60,
            minWidth: double.maxFinite,
            color: Colors.green[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(countries[index]["name"]),
          ),
        );
      },
    );
  }
}
