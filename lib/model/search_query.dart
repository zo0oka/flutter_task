import 'package:flutter_task/enums/filter_operators.dart';
import 'package:flutter_task/enums/filter_options.dart';

class SearchQuery {
  final FilterOptions filterOption;
  final FilterOperators filterOperator;
  final String value;

  SearchQuery(
      {required this.filterOption,
      required this.filterOperator,
      required this.value});
}
