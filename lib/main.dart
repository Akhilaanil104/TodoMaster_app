import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo2app/firebase_options.dart';
import 'package:todo2app/screens/addtask.dart';
import 'package:todo2app/screens/homepage.dart';
import 'package:todo2app/screens/loginpage.dart';
import 'package:todo2app/screens/registerpage.dart';
import 'package:todo2app/screens/splashpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: "/splash",

      routes: {
        "/":(context)=>LoginPage(),
        '/register':(context)=>Registerpage(),
        '/home':(context)=>Homepage(),
        '/add':(context)=>AddTask(),
        '/splash':(context)=>Splashpage()


      },
      debugShowCheckedModeBanner: false,
      title: 'todo',
      theme: ThemeData(

        scaffoldBackgroundColor: Color.fromARGB(255, 15, 18, 193),

        textTheme: TextTheme(
          displayMedium: TextStyle(color: Colors.white,fontSize: 40),
          displaySmall: TextStyle(color: Colors.white,fontSize: 20)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
    );
  }
}


















































