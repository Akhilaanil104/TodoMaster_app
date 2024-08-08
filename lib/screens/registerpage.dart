import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo2app/models/user_model.dart';
import 'package:todo2app/services/auth_service.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();

  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();

  final _regkey = GlobalKey<FormState>();
  bool _isloading = false;

  Future<void> _register() async {
    setState(() {
      _isloading = true;
    });

    _userModel = UserModel(
        email: _emailcontroller.text,
        password: _passcontroller.text,
        name: _namecontroller.text,
        status: 1,
        createdAt: DateTime.now());

    try {
      await Future.delayed(Duration(seconds: 3));

      final userData = await _authService.registerUser(_userModel);
      if (userData != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isloading = false;
      });
      List err = e.toString().split("]");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ThemeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 77, 182),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Form(
              key: _regkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "create an account",
                    style: ThemeData.textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  TextFormField(
                    controller: _namecontroller,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "enter name",
                        hintStyle: TextStyle(color: Colors.white10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "eneter an email id";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "enter email",
                        hintStyle: TextStyle(color: Colors.white10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passcontroller,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "eneter an password ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "enter password",
                        hintStyle: TextStyle(color: Colors.white10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_regkey.currentState!.validate()) {


                        _register();
                        // _userModel = UserModel(
                        //     email: _emailcontroller.text,
                        //     password: _passcontroller.text,
                        //     name: _namecontroller.text,
                        //     status: 1,
                        //     createdAt: DateTime.now());
                        // final userData =
                        //     await _authService.registeruser(_userModel);
                        // if (userData != null) {
                        //   Navigator.pushNamedAndRemoveUntil(context, '/home',
                        //       (Route<dynamic> route) => false);
                        // }

                        // try {
                        //   // Create a user with email and password
                        //   UserCredential userData = await FirebaseAuth.instance
                        //       .createUserWithEmailAndPassword(
                        //     email: _emailcontroller.text.trim(),
                        //     password: _passcontroller.text.trim(),
                        //   );

                        //   // Set user data in Firestore
                        //   await FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(userData.user!.uid)
                        //       .set({
                        //     'uid': userData.user!.uid,
                        //     'email': userData.user!.email,
                        //     'name': _namecontroller.text,
                        //     'createdat': DateTime.now(),
                        //     'status': 1,
                        //   });

                        // onTap: () async {
                        //   if(_regkey.currentState!.validate()){

                        //     UserCredential userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        //           email: _emailcontroller.text.trim(),
                        //           password: _passcontroller.text.trim());

                        //   if(userData !=null){
                        //     await  FirebaseFirestore.instance.collection('users').doc(userData.user!.uid).set({

                        //       'uid':userData.user!.uid ,
                        //       'email':userData.user!.email,
                        //       'name':_namecontroller,
                        //       'createdat':DateTime.now(),
                        //       'status':1

                        //     }).then((value)=>Navigator.pushNamedAndRemoveUntil(context, '/add', (Route<dynamic> route) => false));
                        //   }
                        // }},

                        // Navigate to the add page
                        //   Navigator.pushNamedAndRemoveUntil(
                        //       context, '/home', (Route<dynamic> route) => false);
                        // } catch (error) {
                        //   // Handle any errors here, such as showing an error message to the user
                        //   print("Failed to register user: $error");
                        //   // Show a snackbar or dialog to inform the user of the error
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         content: Text(
                        //             'Failed to register user. Please try again.')),
                        //   );
                        // }
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 260,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 90, 168, 109),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "register",
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("already have an account",
                          style: ThemeData.textTheme.displaySmall),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "login ",
                            style: ThemeData.textTheme.displayMedium,
                          ))
                    ],
                  )
                ],
              ),
            ),
            Visibility(
                visible: _isloading,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        ),
      ),
    );
  }
}
