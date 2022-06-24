import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/helpers/app_colors.dart';
import 'package:flutter_task/helpers/images.dart';
import 'package:flutter_task/model/search_query.dart';
import 'package:flutter_task/providers/filter_provider.dart';
import 'package:flutter_task/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatefulWidget {
  final bool isFirst;
  final void Function(Key)? onRemove;
  const FilterWidget({this.onRemove, this.isFirst = true, Key? key})
      : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late UsersProvider _usersProvider;
  late FilterProvider _filterProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _usersProvider = Provider.of<UsersProvider>(context);
    _filterProvider = Provider.of<FilterProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 104,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.criteriaBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                height: 36,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF808080)
                                        .withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButton<Map<String, dynamic>>(
                                  value: _filterProvider.criteriaValue,
                                  hint: Text(
                                    'Choose Field',
                                    style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.textColor),
                                  ),
                                  icon: SvgPicture.asset(Images.dropArrow),
                                  isExpanded: true,
                                  underline: Container(),
                                  onChanged: (value) {
                                    _filterProvider.setCriteriaValue(value!);
                                    _filterProvider
                                        .selectOperators(value['value']);
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  items: _filterProvider.filterOptions
                                      .map(
                                        (e) => DropdownMenuItem<
                                            Map<String, dynamic>>(
                                          value: e,
                                          child: Text(
                                            e['title'],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.textColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: _filterProvider.operatorWidth,
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      const Color(0xFF808080).withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: DropdownButton<Map<String, dynamic>>(
                                value: _filterProvider.operator,
                                underline: Container(),
                                icon: SvgPicture.asset(Images.dropArrow),
                                isExpanded: true,
                                onChanged: (value) {
                                  _filterProvider.setOperator(value!);
                                },
                                borderRadius: BorderRadius.circular(8),
                                items: _filterProvider.selectedOperators
                                    .map(
                                      (e) => DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: e,
                                        child: Text(
                                          e['title'],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF808080).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type filter',
                              ),
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.textColor),
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: _filterProvider.textInputType,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              onChanged: (text) {
                                SearchQuery query = SearchQuery(
                                    filterOption:
                                        _filterProvider.criteriaValue!['value'],
                                    filterOperator:
                                        _filterProvider.operator!['value'],
                                    value: text);
                                _usersProvider.addQuery(widget.key!, query);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isFirst)
                    const SizedBox(
                      width: 12,
                    ),
                  if (!widget.isFirst)
                    GestureDetector(
                      onTap: () {
                        widget.onRemove!(widget.key!);
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.actionRed,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Images.remove,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Container(
              width: 66,
              height: 36,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF808080).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: DropdownButton<Map<String, dynamic>>(
                value: _filterProvider.andOr,
                underline: Container(),
                icon: SvgPicture.asset(Images.dropArrow),
                isExpanded: true,
                onChanged: (value) {
                  _filterProvider.setAndOr(value!);
                },
                borderRadius: BorderRadius.circular(8),
                items: _filterProvider.andOrOperators
                    .map(
                      (e) => DropdownMenuItem<Map<String, dynamic>>(
                        value: e,
                        child: Text(
                          e['title'],
                        ),
                      ),
                    )
                    .toList(),
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
