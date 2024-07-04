// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String searchText;

  const TodoSearchState(
    this.searchText,
  );

  factory TodoSearchState.initial() {
    return TodoSearchState('');
  }

  @override
  String toString() => 'TodoSearch(searchText: $searchText)';

  @override
  List<Object> get props => [searchText];

  TodoSearchState copyWith({
    String? searchText,
  }) {
    return TodoSearchState(
      searchText ?? this.searchText,
    );
  }

  @override
  bool get stringify => true;
}
