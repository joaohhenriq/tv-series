import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/home_feature/home_feature.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Tv Maze App')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: HomeItem(
                  title: 'Tv Series',
                  onTap: _navigateToTvSeriesSection,
                ),
              ),
              HomeItem(
                title: 'People',
                onTap: _navigateToPeopleSection,
              ),
            ],
          ),
        ),
      );

  void _navigateToTvSeriesSection() =>
      Modular.to.pushNamed(HomeNavigation.tvSeries);

  void _navigateToPeopleSection() =>
      Modular.to.pushNamed(HomeNavigation.peopleSearch);
}
