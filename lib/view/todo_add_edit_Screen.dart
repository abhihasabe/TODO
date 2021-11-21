import 'package:flutter/material.dart';
import 'package:todoapptask/model/todo_model.dart';
import 'package:todoapptask/provider/todos.dart';
import 'package:todoapptask/theme/colors.dart';
import 'package:todoapptask/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:todoapptask/widgets/button_widget.dart';
import 'package:todoapptask/widgets/input_field_widget.dart';
import 'package:todoapptask/widgets/text_widget.dart';

class AddEditTodo extends StatefulWidget {
  final Todo todo;

  const AddEditTodo({Key key, this.todo}) : super(key: key);

  @override
  _AddEditTodoState createState() => _AddEditTodoState();
}

class _AddEditTodoState extends State<AddEditTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleControllerFocus = FocusNode();
  final FocusNode _descriptionControllerFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _selectedPriority;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo.title;
      _descriptionController.text = widget.todo.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
              text: widget.todo != null ? "Edit TODO" : "Add TODO",
              big: true,
              bold: true,
              color: Colors.white)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              _buildTitle(),
              SizedBox(
                height: 10,
              ),
              _buildDescription(),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                hint: _selectedPriority == null
                    ? Text('Propriety', style: TextStyle(color: textColor))
                    : Text(
                        _selectedPriority,
                        style: TextStyle(color: textColor),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(
                    color: primaryColor, decorationColor: primaryColor),
                items: ['Low', 'Medium', 'High'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        style: TextStyle(color: textColor),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _selectedPriority = val;
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              _buildNextButton(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormFieldWidget(
      hintText: "Title",
      textCapitalization: TextCapitalization.sentences,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _titleController,
      focusNode: _titleControllerFocus,
      onSubmitField: () {
        changeFocus(
            context, _titleControllerFocus, _descriptionControllerFocus);
      },
      parametersValidate: "Please enter Title.",
    );
  }

  Widget _buildDescription() {
    return TextFormFieldWidget(
      hintText: "Description",
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      actionKeyboard: TextInputAction.done,
      functionValidate: commonValidation,
      controller: _descriptionController,
      maxLine: 5,
      focusNode: _descriptionControllerFocus,
      onSubmitField: () {},
      parametersValidate: "Please enter Description.",
    );
  }

  Widget _buildNextButton() {
    return raisedButton(
        textColor: Colors.white,
        minWidth: double.infinity,
        text: "SUBMIT",
        height: 50.0,
        borderRadius: 5,
        color: primaryColor,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          addTodo();
        });
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void addTodo() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      hideKeyboard();
      if (widget.todo != null) {
        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.updateTodo(
            widget.todo, _titleController.text, _descriptionController.text);
        Navigator.of(context).pop();
        Utils.displayToast("TODO Created Successfully");
      } else {
        final todo = Todo(
            id: DateTime.now().toString(),
            title: _titleController.text,
            description: _descriptionController.text,
            createdTime: DateTime.now(),
            prority: _selectedPriority);
        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.addTodo(todo);
        Navigator.of(context).pop();
        Utils.displayToast("TODO Created Successfully");
      }
    }
  }
}
