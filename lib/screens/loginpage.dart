// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:todo2app/models/user_model.dart';
// import 'package:todo2app/services/auth_service.dart';


// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {

//   TextEditingController _emailcontroller =TextEditingController();
//   TextEditingController _passcontroller =TextEditingController();

//   final _loginkey=GlobalKey<FormState>();

//   UserModel _userModel=UserModel();
//   AuthService _authService=AuthService();

//   bool _isloading = false;



//   void _login() async{
//     setState(() {
//       _isloading=true;

//     });

//     try{
//       _userModel=UserModel(email: _emailcontroller.text,password: _passcontroller.text,);


//       final date= await _authService.loginUser(_userModel);

//       if (date != null) {
//         Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _isloading = false;
//       });
//       List err = e.toString().split("]");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(err[1])));

//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     // ignore: non_constant_identifier_names
//     final ThemeData=Theme.of(context);
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(20),
//         height: double.infinity,
//         width: double.infinity,
//         child: Stack(
//           children: [
//             Form(
//               key:_loginkey,
//               child: Column(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("login to  your account",style: ThemeData.textTheme.displayMedium,),
//                   SizedBox(height: 37,),
              
//                   TextFormField(
                    
//                     controller: _emailcontroller,
//                     validator: (value) {
//                       if(value!.isEmpty){
//                         return  "eneter an email id";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
              
//                       hintText: "enter email",
//                       hintStyle: TextStyle(color: Colors.white10),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color:Colors.white),
//                         borderRadius: BorderRadius.circular(7)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(7)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   TextFormField(
                    
//                     controller: _passcontroller,
//                     obscureText: true,
//                     validator: (value) {
//                       if(value!.isEmpty){
//                         return  "eneter an password ";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
              
//                       hintText: "enter password",
//                       hintStyle: TextStyle(color: Colors.white10),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color:Colors.white),
//                         borderRadius: BorderRadius.circular(7)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(7)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   InkWell(
//                     onTap: ()async {
//                       if(_loginkey.currentState!.validate()){
//                         _login();
//                       }
                      
                      
//                     },
//                     child: Container(
//                       height: 70,
//                       width: 260,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 90, 168, 109),
//                         borderRadius: BorderRadius.circular(10)
//                       ),
                      
//                       child: Center(child: Text("login",),),
                      
//                       ),
//                   ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("dont have an account",style: ThemeData.textTheme.displaySmall),
//                       SizedBox(width: 20,),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context,'/register');
//                         },
//                         child: Text("create now",style: ThemeData.textTheme.displayMedium,))
//                       ],
//                     )
//                 ],
//               ),
//             ),
          
          
          
//           Visibility(child: Center(child: CircularProgressIndicator(),),
//           visible:_isloading,
          
//           )
          
          
          
//           ],
//         ),
//       ),

      
//     );
//   }




//   _login() async {
//   UserCredential userdata= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text.trim(), password: _passcontroller.text.trim());

//                   if(userdata!=null){
//                     Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic>Route)=>false);
//                   }
// }

// }





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo2app/models/user_model.dart';
import 'package:todo2app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _userModel = UserModel(
        email: _emailController.text,
        password: _passController.text,
      );

      final snap = await _authService.loginUser(_userModel);

      if (snap != null && snap.exists) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
      } else {
        // Handle the case where the document does not exist
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed or user document does not exist")));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Login to your account", style: themeData.textTheme.displayMedium),
                  SizedBox(height: 37),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter an email ID";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter email",
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
                    controller: _passController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter password",
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
                  InkWell(
                    onTap: () async {
                      if (_loginKey.currentState?.validate() ?? false) {
                        _login();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 90, 168, 109),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Login")),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: themeData.textTheme.displaySmall),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text("Create now", style: themeData.textTheme.displayMedium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              child: Center(child: CircularProgressIndicator()),
              visible: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}


































