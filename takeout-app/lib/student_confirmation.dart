import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Text("You're all set"),
      ),
    );
  }

}