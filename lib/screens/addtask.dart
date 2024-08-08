// import 'package:flutter/material.dart';
// import 'package:todo2app/models/todo_model.dart';
// import 'package:todo2app/services/todo_service.dart';
// import 'package:uuid/uuid.dart';
// class Addtask extends StatefulWidget {
//   const Addtask({super.key});

//   @override
//   State<Addtask> createState() => _AddtaskState();
// }

// class _AddtaskState extends State<Addtask> {

//    TextEditingController _titlecontroller=TextEditingController();
//     TextEditingController _desctaskcontroller=TextEditingController();
//     final _todokey=GlobalKey<FormState>();
    

//     @override
//   void dispose() {
//     _titlecontroller.dispose();
//     _desctaskcontroller.dispose();


//     super.dispose();
//   }
  

  
//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.indigoAccent,),

//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
        
//         child:Form(
//           key: _todokey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text("Add task",style: TextStyle(color: Colors.white,fontSize: 29)),
//               SizedBox(height: 3,),
//               Divider(height: 2,color: Colors.teal,
//               endIndent: 30,
              
//               ),
          
//               SizedBox(height: 30,),
//               TextFormField(
                  
//                   controller: _titlecontroller,
//                   obscureText: true,
//                   validator: (value) {
//                     if(value!.isEmpty){
//                       return  "enter task ";
//                     }
//                     return null;
//                     // return null;
//                   },
//                   decoration: InputDecoration(
            
//                     hintText: "enter task",
//                     hintStyle: TextStyle(color: Colors.white10),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color:Colors.white),
//                       borderRadius: BorderRadius.circular(7)
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                       borderRadius: BorderRadius.circular(7)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 TextFormField(
                  
//                   controller: _desctaskcontroller,
//                   validator: (value) {
//                     if(value!.isEmpty){
//                       return  "enter description";
//                     }
//                     return null;
//                     // return null;
//                   },
//                   decoration: InputDecoration(
            
//                     hintText: "enter descreption",
//                     hintStyle: TextStyle(color: Colors.white10),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color:Colors.white),
//                       borderRadius: BorderRadius.circular(7)
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                       borderRadius: BorderRadius.circular(7)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: (){

//                     if(_todokey.currentState!.validate()){
//                       _addtask();
//                     }
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 230,
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 90, 168, 109),
//                       borderRadius: BorderRadius.circular(10)
//                     ),
                    
//                     child: Center(child: Text("Add task",),),
                    
//                     ),
//                 ),
//             ],
//           ),
//         ) ,),
//     );


   
//   }

//    _addtask() async{
//     var id=Uuid().v1();
//     TodoModel _todomodel=TodoModel(title:_titlecontroller.text,body: _desctaskcontroller.text,id: id,status: 1,createdAt: DateTime.now());
//     TodoService _todoservice=TodoService();
//     final  todo= await _todoservice.createtodo(_todomodel);

//     if(todo!=null){
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("task created")));
//     }

  
//   }


  
// }











































import 'package:flutter/material.dart';
import 'package:todo2app/models/todo_model.dart';
import 'package:todo2app/services/todo_service.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  final TodoModel? todo;
  const AddTask({super.key,this.todo});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descTaskController = TextEditingController();
   bool _edit=false;
  
  TodoService _todoService = TodoService();


 

  @override
  void dispose() {
    _titleController.dispose();
    _descTaskController.dispose();
    super.dispose();
  }

  load(){

    if(widget.todo!=null){
    setState(() {
      _titleController.text=widget.todo!.title!;
    _descTaskController.text=widget.todo!.body!;
    _edit=true;
    });
    }
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  final _todoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _todoKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _edit==true? Text("update Task", style: TextStyle(color: Colors.white, fontSize: 29)):
              Text("add new task",style: TextStyle(color: Colors.white,fontSize: 20),),
              SizedBox(height: 3),
              Divider(
                height: 2,
                color: Colors.teal,
                endIndent: 30,
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter task";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter task",
                  hintStyle: TextStyle(color: Colors.white10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descTaskController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter description";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter description",
                  hintStyle: TextStyle(color: Colors.white10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_todoKey.currentState!.validate()) {
                    if(_edit){
      
                      TodoModel _todomodel =TodoModel(
                      id:widget.todo?.id,
                      title:_titleController.text,
                      body:_descTaskController.text,
                      status:widget.todo?.status,
                      createdAt: widget.todo?.createdAt,
                      );
                      
      
                      _todoService.updatetask(_todomodel).then((value)=>Navigator.pop(context));
      
                    }else{
                      _addTask();
                    }
                  }
                },
                child: Container(
                  height: 40,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 90, 168, 109),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _edit==true? Text("update Task"):
                    Text("add  new task",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addTask() async {
    var id = Uuid().v1();
    TodoModel _todoModel = TodoModel(
      title: _titleController.text,
      body: _descTaskController.text,
      id: id,
      status: 1,
      createdAt: DateTime.now(),
    );
    
    final todo = await _todoService.createTodo(_todoModel);

    if (todo != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task created")));
    }
  }
}

