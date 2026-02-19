import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/pages/utulity/dialog_box.dart';
import 'package:todo_list/pages/utulity/todo_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox=Hive.box('mybox');
  ToDoDatabase db =ToDoDatabase();
  @override
  void initState() {
    // TODO: implement initState
    if(_myBox.get("ToDoList")==null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  final _controller=TextEditingController();
  //check box was tapped
  void checkBoxChanged(bool? value ,int index){
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateData();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    db.updateData();
  }
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller:_controller,
        onSave: saveNewTask,
        onCancel:()=>Navigator.of(context).pop(),
      );
    },);
  }
  //delete task
  void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed:createNewTask,
        child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(taskName: db.toDoList[index][0], taskCompleted: db.toDoList[index][1], onChanged: (value)
          =>checkBoxChanged(value,index),
          deleteFunction: (context)=>deleteTask(index),);
        },
      ),
    );
  }
}