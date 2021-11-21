import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapptask/provider/todos.dart';
import 'package:todoapptask/widgets/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  String type;

  TodoListWidget({this.type});

  @override
  Widget build(BuildContext context) {
    var todos;
    final provider = Provider.of<TodosProvider>(context);
    if (type == "completed") {
      todos = provider.todosCompleted;
    } else {
      todos = provider.todos;
    }
    return todos.isEmpty
        ? Center(
            child: Text(
              'No todos.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoWidget(todo: todo, type: type);
            },
          );
  }
}
