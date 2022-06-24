import 'package:flutter/material.dart';
import 'package:flutter_task/screens/results_screen.dart';
import 'package:flutter_task/screens/search_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SearchScreen.route: (context) => const SearchScreen(),
    ResultsScreen.route: (context) => const ResultsScreen(),
  };
}
