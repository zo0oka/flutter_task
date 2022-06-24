import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_task/data/network_repo.dart';
import 'package:flutter_task/enums/filter_operators.dart';
import 'package:flutter_task/enums/filter_options.dart';
import 'package:flutter_task/model/responses/api_response.dart';
import 'package:flutter_task/model/search_query.dart';
import 'package:flutter_task/model/user.dart';

class UsersProvider with ChangeNotifier {
  List<User> users = [];
  List<User> filteredUsers = [];

  Map<Key, SearchQuery> queries = {};

  Future<void> getUsers() async {
    if (users.isEmpty) {
      EasyLoading.show();
      users.clear();
      ApiResponse apiResponse = await NetworkRepo().getUsers();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        users = (apiResponse.response!.data as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList();
        filteredUsers.addAll(users);
        notifyListeners();
        EasyLoading.dismiss();
      }
    }
  }

  void addQuery(Key key, SearchQuery query) {
    if (queries.containsKey(key)) {
      queries.update(key, (value) => query);
    } else {
      queries.putIfAbsent(key, () => query);
    }
  }

  void removeQuery(Key key) {
    queries.removeWhere((itemKey, value) => itemKey == key);
  }

  void filterUsers() {
    queries.forEach((key, value) {
      _performFilter(value);
    });
  }

  void _performFilter(SearchQuery query) {
    // ignore: missing_enum_constant_in_switch
    switch (query.filterOption) {
      case FilterOptions.firstName:
        _filterByFirstName(query.filterOperator, query.value);
        break;
      case FilterOptions.lastName:
        _filterByLastName(query.filterOperator, query.value);
        break;
      case FilterOptions.fullName:
        _filterByFullName(query.filterOperator, query.value);
        break;
      case FilterOptions.gender:
        _filterByGender(query.filterOperator, query.value);
        break;
      case FilterOptions.age:
        _filterByAge(query.filterOperator, query.value);
        break;
    }
  }

  void _filterByFirstName(FilterOperators operator, String value) {
    // ignore: missing_enum_constant_in_switch
    switch (operator) {
      case FilterOperators.stringStartsWith:
        filteredUsers
            .retainWhere((element) => element.firstName!.startsWith(value));
        break;
      case FilterOperators.stringEndsWith:
        filteredUsers
            .retainWhere((element) => element.firstName!.endsWith(value));
        break;
      case FilterOperators.stringContains:
        filteredUsers
            .retainWhere((element) => element.firstName!.contains(value));
        break;
      case FilterOperators.stringIsExact:
        filteredUsers.retainWhere((element) => element.firstName! == (value));
        break;
    }
  }

  void _filterByLastName(FilterOperators operator, String value) {
    // ignore: missing_enum_constant_in_switch
    switch (operator) {
      case FilterOperators.stringStartsWith:
        filteredUsers
            .retainWhere((element) => element.lastName!.startsWith(value));
        break;
      case FilterOperators.stringEndsWith:
        filteredUsers
            .retainWhere((element) => element.lastName!.endsWith(value));
        break;
      case FilterOperators.stringContains:
        filteredUsers
            .retainWhere((element) => element.lastName!.contains(value));
        break;
      case FilterOperators.stringIsExact:
        filteredUsers.retainWhere((element) => element.lastName! == (value));
        break;
    }
  }

  void _filterByFullName(FilterOperators operator, String value) {
    // ignore: missing_enum_constant_in_switch
    switch (operator) {
      case FilterOperators.stringStartsWith:
        filteredUsers
            .retainWhere((element) => element.fullName!.startsWith(value));
        break;
      case FilterOperators.stringEndsWith:
        filteredUsers
            .retainWhere((element) => element.fullName!.endsWith(value));
        break;
      case FilterOperators.stringContains:
        filteredUsers
            .retainWhere((element) => element.fullName!.contains(value));
        break;
      case FilterOperators.stringIsExact:
        filteredUsers.retainWhere((element) => element.fullName! == (value));
        break;
    }
  }

  void _filterByGender(FilterOperators operator, String value) {
    filteredUsers.retainWhere((element) =>
        element.gender!.contains(value) || element.gender! == value);
  }

  void _filterByAge(FilterOperators operator, String value) {
    // ignore: missing_enum_constant_in_switch
    switch (operator) {
      case FilterOperators.numberEquals:
        filteredUsers
            .retainWhere((element) => element.age! == int.parse(value));
        break;
      case FilterOperators.numberNotEquals:
        filteredUsers
            .retainWhere((element) => element.age! != int.parse(value));
        break;
      case FilterOperators.numberIsGreater:
        filteredUsers.retainWhere((element) => element.age! > int.parse(value));
        break;
      case FilterOperators.numberIsLess:
        filteredUsers.retainWhere((element) => element.age! < int.parse(value));
        break;
    }
  }
}
