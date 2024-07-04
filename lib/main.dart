import 'package:flutter/material.dart';
import 'package:to_do_cubit_streamsubscription/cubits/filtered_todo/filtered_todo_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_active_count/todo_activecount_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_search/todo_search_cubit.dart';

import 'presentations/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<TodoActiveCountCubit>(
            create: (context) => TodoActiveCountCubit(todoListCubit: BlocProvider.of<TodoListCubit>(context))),
        BlocProvider<FilteredTodoCubit>(
          create: (context) => FilteredTodoCubit(
              todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
              todoListCubit: BlocProvider.of<TodoListCubit>(context),
              todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context)),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
