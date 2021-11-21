import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapptask/api/firebase_api.dart';
import 'package:todoapptask/model/todo_model.dart';
import 'package:todoapptask/provider/todos.dart';
import 'package:todoapptask/theme/colors.dart';
import 'package:todoapptask/view/todo_complet_list_screen.dart';
import 'package:todoapptask/widgets/text_widget.dart';
import 'package:todoapptask/widgets/todo_list_widget.dart';

import 'todo_add_edit_Screen.dart';

class TODOList extends StatefulWidget {
  const TODOList({Key key}) : super(key: key);

  @override
  _TODOListState createState() => _TODOListState();
}

class _TODOListState extends State<TODOList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text:"TODO's", big: true,bold: true,color: Colors.white),
        actions: <Widget>[IconButton(
              icon: Icon(
                Icons.done,
                color: accentColor,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TODOCompletedList(),
                  ),
                );
              })],
      ),
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

                return TodoListWidget();
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: buttonColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddEditTodo(),
          barrierDismissible: false,
        ),
        child: Icon(
          Icons.add,
          color: accentColor,
        ),
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
