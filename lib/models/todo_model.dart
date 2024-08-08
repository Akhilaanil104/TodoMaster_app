// // lib/models/todo_model.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TodoModel {
//    String? id;
//    String? title;
//    String? body;
//    int? status;
//    DateTime? createdAt;

//   TodoModel({
//     this.id,
//     this.title,
//     this.status,
//     this.body,
//      this.createdAt,
//   });

  

//   factory TodoModel.fromJson(DocumentSnapshot json) {
//     return TodoModel(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//       status: json['status'],
//       // createdAt: json['createdAt']
//       createdAt: (json['createdAt'] as Timestamp).toDate(),
//     );
//   }



//   Map<String,dynamic>toMap(){
//     return {
//       'id':id,
//       'title':title,
//       'body':body,
//       'status':status,
//       // 'createdat':createdAt
//       'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,

//     };

//   }
// }









import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  String? body;
  int? status;
  DateTime? createdAt;

  TodoModel({
    this.id,
    this.title,
    this.body,
    this.status,
    this.createdAt,
  });

  factory TodoModel.fromJson(DocumentSnapshot json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      status: json['status'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'status': status,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}

