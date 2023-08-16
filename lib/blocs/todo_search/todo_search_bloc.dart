import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    // 이벤트 발생 시 상태를 변경
    on<TodoSearchTermChangedEvent>(
      (event, emit) {
        emit(state.copyWith(searchTerm: event.newSearchTerm));
      },
      transformer: debouncd(const Duration(milliseconds: 3000)),
    );
  }

  EventTransformer<TodoSearchTermChangedEvent>
      debouncd<TodoSearchTermChangedEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
