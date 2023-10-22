import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'admin_home_page.dart';

import 'admin_order.dart';
import 'main.dart';
var ans = {};

//returns logged in student's orders as a map
getIndividualOrderHistory() async {
  String id = "";
  print("in get orders");
  await FirebaseFirestore.instance
      .collection('users')
      .doc('K9303KrOwITuk8itlqrg')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic,dynamic>);
      User? user = FirebaseAuth.instance.currentUser;
      if(user!=null){
        String? key = user.email.toString().substring(0,user.email.toString().length-4);
        id = temp[key]['com'];
      }
      else{
        print("Fatal Error: user does not exist");
      }

    } else {
      print('Document does not exist on the database');
    }
  });
  Map orders = {};
  await FirebaseFirestore.instance
      .collection('users')
      .doc('SxHI0lmZHaO8r2BnwtuH')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic,dynamic>);
      for(int i = 0; i<temp.length;i++){
        Map order = temp.values.elementAt(i);
        if(id==order["student-id"]){
          orders[temp.keys.elementAt(i)] = order;
        }
      }
    } else {
      print('Document does not exist on the database');
    }
  });
  print(orders);
  print("orders");
  return orders;
}

class OrderHistory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OrderHistory();
  }

}
class _OrderHistory extends State<OrderHistory>{




  @override
  Widget build(BuildContext context) {

    print("in order page");
    print(ans.toString());
    
    return FutureBuilder<dynamic>(
        future: getIndividualOrderHistory(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){

            ans = snapshot.data;
            print(ans);
            print("anss");

              return Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: _getOrderCards,
                        itemCount: ans.length,
                      ),
                    ),

                    SizedBox(height: 40),
                    const SizedBox()


                  ],
                ),
              );

          }
          else {
            return const CircularProgressIndicator();
          }
        }

    );



  }
  //returns individual order cards
  Widget _getOrderCards(BuildContext context, int index) {
    print("in get orders");
    return OrderTile(context, index,ans,false);
  }
}

