import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/cubits.dart';
import '../../utils/debounce.dart';

import '../../models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  final Debounce debounce = Debounce(milliseconds: 1000);

  // non constant property 인 debounce가 있으므로 const 생성자를 사용할 수 없음.
  SearchAndFilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            debounce.run(() {
              if (newSearchTerm != null) {
                context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
              }
            });
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  // 버튼 선택 시마다 TodoList 의 State 와 Text 색상을 변경시킴.
  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          color: getTextColor(context, filter),
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        context.read<TodoFilterCubit>().chageFilter(filter);
      },
    );
  }

  // TodoList 의 State에 따라 색상을 변경.
  Color getTextColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterCubit>().state.filter;
    return (currentFilter == filter) ? Colors.blue : Colors.black;
  }
}
