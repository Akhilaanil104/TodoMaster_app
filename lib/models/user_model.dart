// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   String? uid;
   String? email;
   String ?name;
   DateTime? createdAt;
   int? status;
   String? password;

  UserModel({
    this.uid,
     this.email,
     this.name,
     this.createdAt,
     this.status,
     this.password
  });

  

  factory UserModel.fromJson(DocumentSnapshot data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      createdAt: data['createdAt'] ,
      status: data['status'],
      
    );
  }

  Map<String,dynamic>toJson(){
    return{
      "uid":uid,
      "name":name,
      "email":email,
      "password":password,
      "status":status,
      "created":createdAt


    };

  }
}
