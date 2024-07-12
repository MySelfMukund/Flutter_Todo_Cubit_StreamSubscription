import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todoListSubscription;
  final int initalActiveTodoCount;
  TodoListCubit todoListCubit;
  ActiveTodoCountCubit({required this.initalActiveTodoCount, required this.todoListCubit})
      : super(ActiveTodoCountState(activeCount: initalActiveTodoCount)) {
    todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) {
      print("todolistState : $todoListState");
      final int currentActiveTodoCount = todoListState.todos.where((Todo t) => !t.isCompleted).toList().length;

      emit(state.copyWith(activeCount: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
