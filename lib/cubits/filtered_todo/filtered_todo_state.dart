// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todo_cubit.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodo;
  const FilteredTodoState({
    required this.filteredTodo,
  });
  factory FilteredTodoState.initials() => FilteredTodoState(filteredTodo: []);

  @override
  String toString() => 'FilteredTodoState(filteredTodo: $filteredTodo)';

  FilteredTodoState copyWith({
    List<Todo>? filteredTodo,
  }) {
    return FilteredTodoState(
      filteredTodo: filteredTodo ?? this.filteredTodo,
    );
  }

  @override
  List<Object?> get props => [filteredTodo];
}
