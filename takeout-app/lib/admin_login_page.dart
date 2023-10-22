import 'package:flutter/material.dart';
import 'admin_home_page.dart';
import 'first_page.dart';

class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Row(
            children: [
              BackButton(),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          InputField(),
          ConfirmButton()
        ],
      ),
    );
  }
}

TextEditingController _credential = TextEditingController();

class InputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputField();
  }
}

class _InputField extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        TextFormField(
          controller: _credential,
          decoration: InputDecoration(
              labelText: "id",
              constraints: BoxConstraints.tight(const Size(250, 100))),
        )
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print(_credential.text);
        if (_credential.text == "admin") {

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
        }
        else{
          _addError(context);
        }
      },
      child: const Text("Confirm"),
    );
  }

  Future<void> _addError (BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incorrect login credentials"),
          content: Container(
            width: 300,
            height: 100,
            child: const Text("Please enter the correct admin key (it is case and space sensitive)"),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        );
      },
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
