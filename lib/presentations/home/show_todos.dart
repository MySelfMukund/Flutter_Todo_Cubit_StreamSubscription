import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_cubit_streamsubscription/cubits/filtered_todo/filtered_todo_cubit.dart';
import 'package:to_do_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoCubit>().state.filteredTodo;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(todos[index].id), //ValueKey(todos[index].id),
          background: showBackGround(0),
          secondaryBackground: showBackGround(1),
          child: TodoListItem(
            todo: todos[index],
          ),
          onDismissed: (_) {
            context.read<TodoListCubit>().removeTodo(todos[index].id);
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you really want to delete?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('NO')),
                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('YES'))
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget showBackGround(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 50.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoListItem extends StatefulWidget {
  final Todo todo;
  const TodoListItem({required this.todo, super.key});

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              bool _error = false;
              textEditingController.text = widget.todo.desc;

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: const Text('Edit Todo'),
                    content: TextFormField(
                      controller: textEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                        errorText: _error ? 'Value cannot be empty' : null,
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCEL')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _error = textEditingController.text.isEmpty ? true : false;
                              if (!_error) {
                                context.read<TodoListCubit>().editTodo(widget.todo.id, textEditingController.text);
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          child: const Text('EDIT'))
                    ],
                  );
                },
              );
            });
      },
      leading: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(
        widget.todo.desc,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
