part of 'todo_search_cubit.dart';

// State 접근 시 type 충돌을 피하기 위해서 state를 Class로 선언함.
class TodoSearchState extends Equatable {
  final String searchTerm;

  const TodoSearchState({required this.searchTerm});

  factory TodoSearchState.initial() => const TodoSearchState(searchTerm: '');

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TodoSerarchState(searchTerm: $searchTerm)';
}
