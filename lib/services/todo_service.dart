// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todo2app/models/todo_model.dart';

// class TodoService{
//   final CollectionReference _todocollection=FirebaseFirestore.instance.collection('todo');





//   Future<TodoModel?>createtodo(TodoModel todo) async{
//     try{

//       final todoMap=TodoModel().toMap();
      
//       await  _todocollection.doc(todo.id).set(todoMap);

//       return todo;

//     }on FirebaseException catch(e){
//       print(e.toString());
//     }
//     return null;

//   }
// }






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo2app/models/todo_model.dart';

class TodoService {
  final CollectionReference _todoCollection = FirebaseFirestore.instance.collection('todo');

  Future<TodoModel?> createTodo(TodoModel todo) async {
    try {
      final todoMap = todo.toMap();

      await _todoCollection.doc(todo.id).set(todoMap);

      return todo;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return null;
  }



  Stream<List<TodoModel> >getalltodo(){
    try{

      return _todoCollection.snapshots().map((QuerySnapshot snapshot){

        return snapshot.docs.map((DocumentSnapshot doc){
          return TodoModel.fromJson(doc);
        }).toList();

      });

    }on FirebaseException catch(e){
      print(e);

      throw(e);
    }


  }Future<void>updatetask(TodoModel todo)async{

    try{
      final todoMap=todo.toMap();

      await _todoCollection.doc(todo.id).update(todoMap);

    }on FirebaseException catch(e){
      print(e.toString());
    }


  }

    Future<void>deletetask(String? id)async{
      try{

        await _todoCollection.doc(id).delete();

      }on FirebaseException catch(e)
      {
        print(e.toString());
      }
    }


  



}
