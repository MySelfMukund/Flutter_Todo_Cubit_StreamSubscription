// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:to_do_cubit_streamsubscription/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_search/todo_search_cubit.dart';
import 'package:to_do_cubit_streamsubscription/models/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  FilteredTodoCubit({
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilteredTodoState.initials()) {
    todoFilterSubscription = todoFilterCubit.stream.listen((TodoFilterState todoFilterState) => setFilterTodos());

    todoSearchSubscription = todoSearchCubit.stream.listen((TodoSearchState todoSearchState) => setFilterTodos());

    todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) => setFilterTodos());
  }

  void setFilterTodos() {
    List<Todo> _filterTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filterTodos = todoListCubit.state.todos.where((Todo todo) => !todo.isCompleted).toList();
        break;
      case Filter.completed:
        _filterTodos = todoListCubit.state.todos.where((Todo todo) => todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        _filterTodos = todoListCubit.state.todos;
        break;
    }
    if (todoSearchCubit.state.searchText.isNotEmpty) {
      _filterTodos = _filterTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(todoSearchCubit.state.searchText.toLowerCase()))
          .toList();
    }
    emit(state.copyWith(filteredTodo: _filterTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();

    return super.close();
  }
}
