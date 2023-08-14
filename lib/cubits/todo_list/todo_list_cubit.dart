import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
    print('*** TODO State : $state');
  }

  // 수정사항이 있다면 state 전체( state.todos )를 바꾸는 방식.
  void editTodo(String id, String todoDesc) {
    // 기존 State의 todos를 map으로 순회하면서
    final newTodos = state.todos.map(
      (Todo todo) {
        // 동일한 기존 id 가 존재하면
        if (todo.id == id) {
          return Todo(
            id: id,
            desc: todoDesc, // 새로운 desc로 변경
            completed: todo.completed,
          );
        } else {
          return todo;
        }
      },
    ).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map(
      (Todo todo) {
        if (todo.id == id) {
          return Todo(
            id: id,
            desc: todo.desc,
            completed: !todo.completed,
          );
        } else {
          return todo;
        }
      },
    ).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void removeTodo(Todo todo) {
    final newTodos = state.todos
        .where(
          (Todo old) => old.id != todo.id,
        )
        .toList();
    // state.todos.where((Todo old) {
    //   if(old.id != todo.id) {return true;}
    //   else {return false;}
    // }).toList();
    emit(state.copyWith(todos: newTodos));
  }
}
