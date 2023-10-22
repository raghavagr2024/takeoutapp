import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student_home.dart';
import 'student_sign_up.dart';



TextEditingController _email = TextEditingController();
class VerificationPage extends StatefulWidget{
  var temp;
  VerificationPage(
      this.temp,
      );

  @override
  State<VerificationPage> createState() {
    _email = temp;
    return _VerificationPage();
  }
}

class _VerificationPage extends State<VerificationPage> {
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  var valid = false;

  void handleTimeout() {
    User? user = FirebaseAuth.instance.currentUser;

    if(user!=null){
      log("not verified");
      user.reload();
    }
    if (user != null && user.emailVerified) {
      CollectionReference reference = FirebaseFirestore.instance.collection("users");
      reference.doc("K9303KrOwITuk8itlqrg").update({
        user.email.toString() : studentID.text
      });
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      scheduleTimeout(5);
    }
  }
  @override
  void initState() {
    scheduleTimeout(5);
  }
  @override
  Widget build(BuildContext context) {
    log(_email.text);

    return Scaffold(
      body: Column(
        children: <Widget>[
          EmailVerificationField(),
          VerificationButton()
        ],
      ),
    );
  }
}



class EmailVerificationField extends StatefulWidget{
  @override
  State<EmailVerificationField> createState() => _EmailVerifiedField();
}

class _EmailVerifiedField extends State<EmailVerificationField>{
  @override
  Widget build(BuildContext context) {

    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'email',
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


class VerificationButton extends StatefulWidget{
  @override
  State<VerificationButton> createState() => _VerificationButton();
}

class _VerificationButton extends State<VerificationButton>{
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  var valid = false;
  void handleTimeout() {
    log("timer over");
    setState(() {
      valid = true;
    });
  }

  @override
  void initState(){
    log("in schedule timeout");
    scheduleTimeout(60000);
  }
  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: valid ? () => sendEmail() : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        child: const Text("Resend email")
    );

  }

  Future<void> sendEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    log("in pressed");
    if(user == null){
      log("user is null");
    }
    setState(() {
      valid = false;
    });

    if (user!= null && !user.emailVerified) {
      await user.sendEmailVerification();
      valid = false;
      scheduleTimeout(60000);
      log("sent");
    }
    else{
      log("email sending error");
    }
  }

}