import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/active_todo_count/active_todo_count_cubit.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
        // BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
        //   builder: (context, state) {
        //     return Text(
        //       '${state.activeTodoCount} items left',
        //       style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
        //     );
        //   },
        // ),
        Text(
          '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
