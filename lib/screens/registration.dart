import 'package:chatapp/screens/chat_app.dart';
import 'package:chatapp/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'constatnt.dart';

void main() {
  runApp(registrationPage());
}
class registrationPage extends StatefulWidget {
  @override
  State<registrationPage> createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
  @override
Widget build(BuildContext context) {
 bool isLoading = false;
 String? email ;
 String? Password ;
 GlobalKey<FormState> formKey = GlobalKey();
 String? validateEmail(String? value) {
   const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
       r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
       r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
       r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
       r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
   final regex = RegExp(pattern);
   if(value!.isEmpty){
     return 'please enter email';
   }
   return value!.isNotEmpty && !regex.hasMatch(value)
       ? 'Enter a valid email address'
       : null;
 };
 String? validatePassword(String? value) {
   /*
     (?=.*[A-Z])       // should contain at least one upper case
     (?=.*[a-z])       // should contain at least one lower case
     (?=.*?[0-9])      // should contain at least one digit
     (?=.*?[!@#\$&*~]) // should contain at least one Special character
       .{8,}             // Must be at least 8 characters in length

    */

   RegExp regex =
   RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
   if (value!.isEmpty) {
     return 'Please enter password';
   } else {
     if (!regex.hasMatch(value)) {
       return 'Enter valid password';
     } else {
       return null;
     }
   }
 };
  return MaterialApp(
    home: Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPriamryColor,
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('images/logo2.png',
                      width: 150,
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
                    children:[ Text('Register' ,
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
                    validator: validatePassword ,
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
                         UserCredential user = await auth.createUserWithEmailAndPassword(
                             email: email!, password: Password!);
                             showSuccess('registration success', context);
                             Navigator.pushNamed(context, chatPage.id , arguments: email);
                       }catch(e){
                             showError('wrong data', context);
                       }

                     }
                  } ,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: const Center(
                        child: Text('Register'),
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
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text('Login' ,
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
    ),
  );
}
}