import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapptask/model/todo_model.dart';
import 'package:todoapptask/provider/todos.dart';
import 'package:todoapptask/theme/colors.dart';
import 'package:todoapptask/view/todo_add_edit_Screen.dart';
import 'package:todoapptask/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:todoapptask/view/todo_details_screen.dart';
import 'package:todoapptask/widgets/text_widget.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  String type;

  TodoWidget({
    @required this.todo,
    this.type,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(8), child: buildTodo(context));

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => showTodo(context, todo),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: todo.prority == "High"
                          ? Colors.red
                          : todo.prority == "Medium"
                              ? Colors.yellow
                              : todo.prority == "Low"
                                  ? Colors.green
                                  : Colors.red,
                      child: Center(
                        child: Text(
                          todo.prority == "High"
                              ? "H"
                              : todo.prority == "Medium"
                                  ? "M"
                                  : todo.prority == "Low"
                                      ? "L"
                                      : "H",
                          style: TextStyle(
                              color: accentColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: TextWidget(
                      text: todo.title,
                      maxLines: 1,
                      big: true,
                    ),
                    subtitle: TextWidget(
                        text:
                            "${DateFormat("y-MM-dd HH:mm").format(todo.createdTime)}",
                        smaller: true,
                        color: textColor,
                        maxLines: 1),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.more_vert,
                        color: buttonColor,
                      ),
                      onTap: () {
                        if (type == "completed") {
                          showCompltedPopupMenu(context, todo, type);
                        } else {
                          showPopupMenu(context, todo, type);
                        }
                      },
                    )),
              ],
            )),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddEditTodo(todo: todo),
        ),
      );

  void showTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TODODetails(todo: todo),
        ),
      );

  showPopupMenu(BuildContext context, Todo todo, String type) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(150.0, 180.0, 100.0, 100.0),
      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Complete'), value: '1'),
        PopupMenuItem<String>(child: const Text('Edit'), value: '2'),
        PopupMenuItem<String>(child: const Text('Delete'), value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;
      if (itemSelected == "1") {
        final provider = Provider.of<TodosProvider>(context, listen: false);
        final isDone = provider.toggleTodoStatus(todo);
        Utils.showSnackBar(
          context,
          isDone ? 'Task completed' : 'Task marked incomplete',
        );
      } else if (itemSelected == "2") {
        editTodo(context, todo);
      } else if (itemSelected == "3") {
        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.removeTodo(todo);
      }
    });
  }

  showCompltedPopupMenu(BuildContext context, Todo todo, String type) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(150.0, 180.0, 100.0, 100.0),
      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Restore'), value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;
      if (itemSelected == "1") {
        final provider = Provider.of<TodosProvider>(context, listen: false);
        final isDone = provider.toggleTodoStatus(todo);
        //provider.removeTodo(todo);
        Navigator.of(context).pop();
        Utils.showSnackBar(
          context,
          isDone ? 'Task completed' : 'Task marked incomplete',
        );
      }
    });
  }
}
