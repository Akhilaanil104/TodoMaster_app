import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo2app/models/todo_model.dart';
import 'package:todo2app/screens/addtask.dart';
import 'package:todo2app/services/auth_service.dart';
import 'package:todo2app/services/todo_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TodoService _todoservice=TodoService();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 64, 192),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Hi",
                        style: themedata.textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "Akhila",
                        style: themedata.textTheme.displaySmall,
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                      onPressed: () async {
                        AuthService().logout().then((value) =>
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (Route<dynamic> route) => false));
                      },
                      icon: Icon(Icons.logout)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Text(
              "Your TodoList",
              
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: Colors.white),
            ),
            Divider(),

            SizedBox(height: 40,),

            // Expanded(
            //   // child: ListView.builder(

            //   //   // shrinkWrap: true,

            //   //   itemCount: 10,
            //   //   itemBuilder: (context, index) {
            //   //   return Card(

            //   //     elevation: 0.5,
            //   //     color: Color.fromARGB(255, 7, 20, 93),
            //   //     child: ListTile(

            //   //       title: Text("todo",style: TextStyle(fontSize: 23,color: Colors.white),),
            //   //       leading:CircleAvatar(
            //   //         backgroundColor: Colors.transparent,
            //   //         child: Icon(Icons.circle_outlined,color: Colors.white,),),

            //   //         subtitle: Text("complete this before 10 pm",style: TextStyle(fontSize: 19,color: Colors.white),),

            //   //         trailing: Container(

            //   //           width: 100,
            //   //           height: 150,
            //   //           child: Row(children: [
            //   //             IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.deepPurpleAccent,)),

            //   //             IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,))
            //   //           ],),
            //   //         ),
            //   //     ),
            //   //   );
            //   // },),
            // ),

            StreamBuilder<List<TodoModel>>(
                stream:
                    _todoservice.getalltodo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
            
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "some error occured",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  }
            
                  if (snapshot.hasData && snapshot.data!.length == 0) {
                    return Center(
                      child: Text(
                        "no task added",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  }
            
                  if (snapshot.hasData && snapshot.data!.length !=0) {
            
            
                    List<TodoModel> todo=snapshot.data??[];
                    return Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
            
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          TodoModel _todoModel = TodoModel();
            
                          final _todo =
                              todo[index];
                              print(_todo);
            
                          return Card(
                            elevation: 0.5,
                            color: Color.fromARGB(255, 7, 20, 93),
                            child: ListTile(
                              title: Text(
                        "${_todo.title}",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                "${_todo.body}",
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                              trailing: Container(
                                width: 100,
                                height: 150,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
            
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTask(todo: _todo,)));
            
                                        
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.deepPurpleAccent,
                                        )),
                                    IconButton(
                                        onPressed: () {
            
                                          _todoservice.deletetask(_todo.id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
            
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
