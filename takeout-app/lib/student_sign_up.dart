import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student_login.dart';
import 'student_verification.dart';
late TextEditingController _name;
late TextEditingController _email;
late TextEditingController _password;
late TextEditingController studentID;
bool temp = false;
class SignUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          EmailTextField(),
          const SizedBox(height: 30),
          PasswordTextField(),
          const SizedBox(height: 30),
          StudentIDTextField(),
          const SizedBox(height: 30),
          NameTextField(),
          const SizedBox(height: 50),
          SignupButton(),
          const SizedBox(height: 10),
          LoginNavigator()

        ],
      )
    );
  }
}

class NameTextField extends StatefulWidget{
  @override
  State<NameTextField> createState() => _NameTextField();
}
class _NameTextField extends State<NameTextField>{

  @override
  void initState(){
    super.initState();
    _name = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
            width: 250,
            child: TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Color(0xFFc99a2c)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFc99a2c)),
                  ),
                ),
              ),
      )
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
              labelStyle: TextStyle(color: Color(0xFFc99a2c)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFc99a2c)),
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
              labelStyle: TextStyle(color: Color(0xFFc99a2c)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFc99a2c)),
              ),
            ),
          ),
        )
    );
  }

}
class StudentIDTextField extends StatefulWidget{
  @override
  State<StudentIDTextField> createState() => _StudentIDTextField();
}
class _StudentIDTextField extends State<StudentIDTextField>{

  @override
  void initState(){
    super.initState();
    studentID = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: studentID,
            decoration: const InputDecoration(
              labelText: 'Student ID',
              labelStyle: TextStyle(color: Color(0xFFc99a2c)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFc99a2c)),
              ),
            ),
          ),
        )
    );
  }

}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await _signUpWithEmailAndPassword();
          log(_email.text);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerificationPage(_email)));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        child: const Text("Sign up")
    );
  }

  Future<UserCredential?> _signUpWithEmailAndPassword() async {
    //create a timer that expires the email
    //if email is resent then they can still be verified
    //if email is expired and they go back delete their account
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      user?.reload();
      if (user!= null && !user.emailVerified) {
        await user.sendEmailVerification();
        log("sent");
      }
    }
    on FirebaseAuthException catch (e) {
      /// These are two examples of several possible error messages from
      /// FirebaseAuth. Find the [complete list of error messages here.](https://firebase.google.com/docs/auth/admin/errors)
      log(e.code);
    }
  }
}

class LoginNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFc99a2c),
      ),
      onPressed: (){

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: const Text("Have an account? Login Instead"),

    );
  }

}