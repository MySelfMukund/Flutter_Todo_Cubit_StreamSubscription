import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_active_count/active_todo_count_cubit.dart';
import 'package:to_do_cubit_streamsubscription/presentations/home/search_and_fileter_todo.dart';
import 'package:to_do_cubit_streamsubscription/presentations/home/show_todos.dart';
import 'package:to_do_cubit_streamsubscription/presentations/home/todo_header.dart';

import 'create_todo.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TodoHeader(),
            CreateTodo(),
            SizedBox(
              height: 20,
            ),
            SearchAndFilterTodo(),
            ShowTodos(),
          ],
        ),
      )),
    );
  }
}
