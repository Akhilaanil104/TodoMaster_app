import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {

  String? name;
  String? email;
  String? uid;
  String? token;

  getdata() async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    token= await _pref.getString('token');
    email= await _pref.getString('email');
    uid= await _pref.getString('uid');
    name= await _pref.getString('name');

    
    

  }


  @override
  void initState() {
    getdata();

    var d =Duration(seconds: 2);
    Future.delayed(d,(){
      checkloginstatus();
      });




    
;    
    super.initState();
  }


  Future<void>checkloginstatus()async{
    if(token==null){
      Navigator.pushNamed(context, "/");
    }
    else{
      Navigator.pushNamed(context, "/home");
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("ToDo",style: TextStyle(color: Colors.white,fontSize: 30)),),
    );
  }
}