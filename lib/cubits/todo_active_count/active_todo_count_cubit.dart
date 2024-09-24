import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initalActiveTodoCount;
  final TodoListCubit todoListCubit;
  ActiveTodoCountCubit({required this.initalActiveTodoCount, required this.todoListCubit})
      : super(ActiveTodoCountState(activeCount: initalActiveTodoCount));
  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(activeCount: activeTodoCount));
  }
}
