import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

part 'todo_activecount_state.dart';

class TodoActiveCountCubit extends Cubit<TodoActivecountState> {
  late final StreamSubscription todoListSubscription;
  TodoListCubit todoListCubit;
  TodoActiveCountCubit({required this.todoListCubit}) : super(TodoActivecountState.initial()) {
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
