import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/helpers/app_colors.dart';
import 'package:flutter_task/helpers/images.dart';
import 'package:flutter_task/providers/user_provider.dart';
import 'package:flutter_task/widgets/user_widget.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  static const String route = 'results_screen';
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late UsersProvider _usersProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _usersProvider = Provider.of<UsersProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.resultsBackground,
      appBar: AppBar(
        backgroundColor: AppColors.resultsBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            Images.backArrow,
            fit: BoxFit.scaleDown,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: _usersProvider.filteredUsers.length,
        itemBuilder: (context, index) {
          return UserWidget(
            user: _usersProvider.filteredUsers[index],
          );
        },
      ),
    );
  }
}
