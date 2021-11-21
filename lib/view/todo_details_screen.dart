import 'package:flutter/material.dart';
import 'package:todoapptask/model/todo_model.dart';
import 'package:todoapptask/theme/colors.dart';
import 'package:todoapptask/widgets/text_widget.dart';

class TODODetails extends StatefulWidget {
  final BuildContext context;
  final Todo todo;

  const TODODetails({this.todo, this.context, Key key}) : super(key: key);

  @override
  _TODODetailsState createState() => _TODODetailsState();
}

class _TODODetailsState extends State<TODODetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(text:"TODO Details", big: true,bold: true,color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          TextWidget(
              text: widget.todo.title, big: true, color: textColor, bold: true),
          SizedBox(height: 10,),
          TextWidget(
              text: widget.todo.description, small: true, color: textColor),
        ]),
      ),
    );
  }
}
