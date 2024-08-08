// // lib/services/auth_service.dar

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todo2app/models/user_model.dart';

// class AuthService {
//   final FirebaseAuth _auth=FirebaseAuth.instance;
//   final CollectionReference _usercollection=FirebaseFirestore.instance.collection('Users');


//   Future<UserCredential?>registeruser(UserModel user)  async{
//     UserCredential userData = await FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                         email: user.email.toString(),
//                         password:user.password.toString(),
//                           );

//                         if(userData !=null){
//                           await  FirebaseFirestore.instance.collection('users').doc(userData.user!.uid).set({

//                             'uid':userData.user!.uid ,
//                             'email':userData.user!.email,
//                             'name':user.name,
//                             'createdat':user.createdAt,
//                             'status':user.status

//                           });

//                           return userData;

//   }

 
// }

//              //LOGIN


// Future<DocumentSnapshot?> loginuser(UserModel user)async{

//   DocumentSnapshot? snap;

//   SharedPreferences _pref =await SharedPreferences.getInstance();

//   UserCredential userCredential=  await _auth.signInWithEmailAndPassword(email: user.email.toString(), password: user.password.toString());


//   String? token= await userCredential.user!.getIdToken();



//   if(userCredential!=null){




//     snap= await _usercollection.doc(userCredential.user!.uid).get(); 
    
//     await _pref.setString('token', token!);
//     await _pref.setString('name', snap['name']);
//     await _pref.setString('email', snap['email']);

//     return snap;
//      }
// }


// Future<void>logout() async{
//   SharedPreferences _pref=await SharedPreferences.getInstance();
//   await _pref.clear();
//   await _auth.signOut();
// }

// Future<bool>isloggedin() async{
//   SharedPreferences _pref= await SharedPreferences.getInstance();
//   String? _token=await _pref.getString('token');

//   if(_token==null){
//     return false;
//   }
//   else{
//     return true;
//   }



// }

// }































import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo2app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<UserCredential?> registerUser(UserModel user) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: user.email.toString(),
        password: user.password.toString(),
      );

      if (userData != null) {
        await _userCollection.doc(userData.user!.uid).set({
          'uid': userData.user!.uid,
          'email': userData.user!.email,
          'name': user.name,
          'createdat': user.createdAt,
          'status': user.status,
        });

        return userData;
      }
      return null;
    } catch (e) {
      print("Registration failed: $e");
      return null;
    }
  }

  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(),
        password: user.password.toString(),
      );

      if (userCredential.user != null) {
        String? token = await userCredential.user!.getIdToken();

        DocumentSnapshot snap = await _userCollection.doc(userCredential.user!.uid).get();

        if (snap.exists) {
          await _pref.setString('token', token!);
          await _pref.setString('name', snap['name']);
          await _pref.setString('email', snap['email']);
          await _pref.setString('uid', snap['uid']);


          return snap;
        } else {
          print("User document does not exist");
          return null;
        }
      }
      return null;
    } catch (e) {
      print("Login failed: $e");
      return null;
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.clear();
      await _auth.signOut();
    } catch (e) {
      print("Logout failed: $e");
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      String? _token = await _pref.getString('token');
      return _token != null;
    } catch (e) {
      print("Failed to check login status: $e");
      return false;
    }
  }
}





