import 'package:flutter/material.dart';
import 'package:flutter_task/enums/filter_operators.dart';
import 'package:flutter_task/enums/filter_options.dart';

class FilterProvider with ChangeNotifier {
  final List<Map<String, dynamic>> filterOptions = [
    {'title': 'First Name', 'value': FilterOptions.firstName},
    {'title': 'Last Name', 'value': FilterOptions.lastName},
    {'title': 'Full Name', 'value': FilterOptions.fullName},
    {'title': 'Gender', 'value': FilterOptions.gender},
    {'title': 'Age', 'value': FilterOptions.age},
  ];

  final List<Map<String, dynamic>> numberFilterOperators = [
    {'title': '=', 'value': FilterOperators.numberEquals},
    {'title': '!=', 'value': FilterOperators.numberNotEquals},
    {'title': '>', 'value': FilterOperators.numberIsGreater},
    {'title': '<', 'value': FilterOperators.numberIsLess},
  ];
  final List<Map<String, dynamic>> stringFilterOperators = [
    {'title': 'startsWith', 'value': FilterOperators.stringStartsWith},
    {'title': 'endsWith', 'value': FilterOperators.stringEndsWith},
    {'title': 'contains', 'value': FilterOperators.stringContains},
    {'title': 'exact', 'value': FilterOperators.stringIsExact},
  ];

  final List<Map<String, dynamic>> selectedOperators = [];

  final List<Map<String, dynamic>> andOrOperators = [
    {'title': 'AND', 'value': FilterOperators.and},
    {'title': 'OR', 'value': FilterOperators.or},
  ];

  double numOperatorWidth = 66;
  double stringOperatorWidth = 120;
  double operatorWidth = 66;

  Map<String, dynamic>? criteriaValue;
  Map<String, dynamic>? operator;
  Map<String, dynamic>? andOr;

  TextInputType textInputType = TextInputType.text;

  void setCriteriaValue(Map<String, dynamic> value) {
    criteriaValue = value;
    operator = null;
    notifyListeners();
  }

  void setOperator(Map<String, dynamic> value) {
    operator = value;
    notifyListeners();
  }

  void setAndOr(Map<String, dynamic> value) {
    andOr = value;
    notifyListeners();
  }

  void selectOperators(FilterOptions option) {
    switch (option) {
      case FilterOptions.userId:
        break;
      case FilterOptions.firstName:
      case FilterOptions.lastName:
      case FilterOptions.fullName:
      case FilterOptions.gender:
        selectedOperators.clear();
        selectedOperators.addAll(stringFilterOperators);
        operator = selectedOperators[0];
        operatorWidth = stringOperatorWidth;
        textInputType = TextInputType.text;
        notifyListeners();
        break;
      case FilterOptions.age:
        selectedOperators.clear();
        selectedOperators.addAll(numberFilterOperators);
        operator = selectedOperators[0];
        operatorWidth = numOperatorWidth;
        textInputType = TextInputType.number;
        notifyListeners();
        break;
    }
  }
}
