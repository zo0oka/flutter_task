import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_task/helpers/app_colors.dart';
import 'package:flutter_task/helpers/app_routes.dart';
import 'package:flutter_task/screens/search_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',
      theme: Theme.of(context).copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: SearchScreen.route,
      routes: AppRoutes.routes,
      // home: const SearchScreen(),
      builder: EasyLoading.init(),
    );
  }
}
