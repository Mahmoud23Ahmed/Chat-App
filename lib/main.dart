import 'package:chatapp/screens/chat_app.dart';
import 'package:chatapp/screens/login_page.dart';
import 'package:chatapp/screens/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {  @override
Widget build(BuildContext context) {
  return MaterialApp(
    routes:{ 'LoginPage' : (context) => LoginPage(),
      'registrationPage' : (context) => registrationPage(),
      chatPage.id:(context)=> chatPage(),
    },
    initialRoute : 'LoginPage' ,
  );
}
}