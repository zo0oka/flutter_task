import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/helpers/images.dart';
import 'package:flutter_task/providers/user_provider.dart';
import 'package:flutter_task/screens/results_screen.dart';
import 'package:flutter_task/widgets/filter_widget.dart';
import 'package:flutter_task/widgets/search_header.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String route = 'search_screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late UsersProvider _usersProvider;
  List<FilterWidget> filterWidgets = [
    FilterWidget(
      key: UniqueKey(),
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _usersProvider = Provider.of<UsersProvider>(context);
    _usersProvider.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchHeader(
              onAdd: () {
                setState(() {
                  filterWidgets.add(const FilterWidget());
                });
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(
                filterWidgets.length,
                (index) => FilterWidget(
                  key: UniqueKey(),
                  isFirst: index == 0,
                  onRemove: (key) {
                    setState(() {
                      filterWidgets.removeAt(index);
                    });
                    _usersProvider.removeQuery(key);
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  _usersProvider.filterUsers();
                  Navigator.pushNamed(context, ResultsScreen.route)
                      .then((value) {
                    _usersProvider.filteredUsers.clear();
                    _usersProvider.filteredUsers.addAll(_usersProvider.users);
                  });
                },
                child: SizedBox(
                  height: 52,
                  child: Center(
                    child: SvgPicture.asset(Images.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
