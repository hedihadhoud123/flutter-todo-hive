import 'package:hive/hive.dart';

class ToDoDatabase{
  List toDoList=[];
  final _mybox=Hive.box('myBox');
  //only first time opening this
  void createInitialData(){
    toDoList=[
      ["make tutorial",false],
      ["to exercice",false],
    ];
    updateData();
  }
  void loadData(){
    toDoList=_mybox.get("ToDoList");
  }
  void updateData(){
    _mybox.put("ToDoList",toDoList);
  }
}