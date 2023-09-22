
import 'package:chatapp/screens/chat_app.dart';
import 'package:chatapp/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'constatnt.dart';

class LoginPage extends StatefulWidget {  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
Widget build(BuildContext context) {
    bool isLoading = false;
    String? email ;
    String? Password ;
    GlobalKey<FormState> formKey = GlobalKey();

  return MaterialApp(
    home: Scaffold(
      backgroundColor: kPriamryColor,
      body:ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset('images/logo2.png',
                     width: 100,
                     height: 150,
                     fit:BoxFit.fill
                 ),
                Center(
                  child: Text('Chat App' ,
                    style:TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children:[ Text('Login' ,
                    style:TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ))],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validateEmail ,
                  onChanged : (data){
                    email = data ;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ), ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (data){
                    Password = data;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ), ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
            GestureDetector(
              onTap : () async {
                if (formKey.currentState!.validate()) {
                  isLoading = true ;
                  setState(() {});
                  try{
                    var auth = FirebaseAuth.instance ;
                    UserCredential user = await auth.signInWithEmailAndPassword(
                        email: email!, password: Password!);
                        Navigator.pushNamed(context, chatPage.id , arguments: email);
                  }catch(e){
                    showError('wrong user' , context);
                  }
                }
              } ,
                child : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: Text('Login'),
                  ),
                ),
            ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account? ' ,
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'registrationPage');
                      },
                      child: Text('REGISTER' ,
                        style: TextStyle(
                          color: Colors.purple,
                        ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}}