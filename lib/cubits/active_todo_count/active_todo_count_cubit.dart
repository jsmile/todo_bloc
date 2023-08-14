import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';
import '../todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  // 연결(감시) 대상 State의 Cubit 선언
  final TodoListCubit todoListCubit;
  // 생성자의 body 에서 초기화가 가능하도록 late 키워드를 사용.
  late final StreamSubscription todoListSubscription;
  // 초기 TODO List count 반영 시 사용
  final int initialActiveTodoCount;

  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final activeTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      emit(state.copyWith(activeTodoCount: activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
