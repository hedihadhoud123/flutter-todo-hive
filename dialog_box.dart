import 'package:flutter/material.dart';
import 'package:todo_list/pages/utulity/my_button.dart';
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({super.key,required this.controller,required this.onSave,required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(height: 120,child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        //get user input
        TextField(
          controller:controller,
          decoration:InputDecoration(border: OutlineInputBorder(),hintText: 'Add a new task'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          // save button
          MyButton(text: "save", onPressed:onSave),
          const SizedBox(width: 7,),
          // cancel button
          MyButton(text: "cancel", onPressed: onCancel),
  ],)
        //button save and cancel
      ],),),

    );
  }
}
