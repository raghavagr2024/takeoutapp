
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student_home.dart';
import 'student_sign_up.dart';

import 'first_page.dart';
import 'student_verification.dart';

late TextEditingController _email, _password;
class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Row(
            children: [
              BackButton(),
            ],
          ),
          const SizedBox(height: 20),
          EmailTextField(),
          const SizedBox(height: 20),
          PasswordTextField(),
          const SizedBox(height:30),
          LoginButton(),
          const SizedBox(height: 30),SignUpNavigator()

        ],
      ),
    );
  }

}
class EmailTextField extends StatefulWidget{
  @override
  State<EmailTextField> createState() => _EmailTextField();
}
class _EmailTextField extends State<EmailTextField>{

  @override
  void initState(){
    super.initState();
    _email = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF1f5d39)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1f5d39)),
              ),
            ),
          ),
        )
    );
  }

}
class PasswordTextField extends StatefulWidget{
  @override
  State<PasswordTextField> createState() => _PasswordTextField();
}
class _PasswordTextField extends State<PasswordTextField>{

  @override
  void initState(){
    super.initState();
    _password = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color(0xFF1f5d39)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1f5d39)),
              ),
            ),
          ),
        )
    );
  }

}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {

          await _login();
          User? user = FirebaseAuth.instance.currentUser;
          // if(user!= null && !user.emailVerified){
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => VerificationPage(_email)));
          // }
          // else{
          //    createCount();
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => HomePage()));
          // }


            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()));

        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1f5d39),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        child: const Text("Log in")
    );
  }

  Future<UserCredential?> _login() async {
    //create a timer that expires the email
    //if email is resent then they can still be verified
    //if email is expired and they go back delete their account
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );


    }

    on FirebaseAuthException catch (e) {
      /// These are two examples of several possible error messages from
      /// FirebaseAuth. Find the [complete list of error messages here.](https://firebase.google.com/docs/auth/admin/errors)
      log(e.code);
    }
  }
}

class SignUpNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1f5d39),
      ),
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: const Text("Don't have an account? Sign up Instead"),

    );
  }

}

class BackButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage()));
        },
        icon: Icon(Icons.arrow_back_ios_new)
    );
  }

}