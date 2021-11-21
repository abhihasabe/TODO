import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapptask/api/firebase_api.dart';
import 'package:todoapptask/model/todo_model.dart';
import 'package:todoapptask/provider/todos.dart';
import 'package:todoapptask/theme/colors.dart';
import 'package:todoapptask/widgets/text_widget.dart';
import 'package:todoapptask/widgets/todo_list_widget.dart';

import 'todo_add_edit_Screen.dart';

class TODOCompletedList extends StatefulWidget {
  const TODOCompletedList({Key key}) : super(key: key);

  @override
  _TODOCompletedListState createState() => _TODOCompletedListState();
}

class _TODOCompletedListState extends State<TODOCompletedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(text:"Completed TODO's", big: true,bold: true,color: Colors.white)),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);

                return TodoListWidget(type:"completed");
              }
          }
        },
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
