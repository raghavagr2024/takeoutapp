import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'admin_login_page.dart';
import 'admin_edit.dart';
import 'student_sign_up.dart';

import 'admin_home_page.dart';
import 'student_home.dart';
import 'student_login.dart';
import 'main.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){



    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),

          const Text("Takeout App", style: TextStyle(fontSize: 35),),
          const SizedBox(height: 200,),
          AdminButton(),
          const SizedBox(height: 50,),
          StudentButton()

        ],
      ),
    );
  }
}

class AdminButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1f5d39),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLogin()));
          },

          child: const Text("Admin")
      );
  }
}
class StudentButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        },

        child: const Text("Student")
    );
  }
}

