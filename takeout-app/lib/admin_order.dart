import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'admin_home_page.dart';
import 'admin_home_page.dart';
import 'main.dart';


class OrderPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderPage();
  }

}

class _OrderPage extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    print("in order page");

    return FutureBuilder<dynamic>(
      future: getOrders(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            orders = snapshot.data;
            print(orders);
            print("orders");
            return Column(
              children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: _getOrders,
                      itemCount: orders.length,
                    ),
                  ),
                SizedBox(height: 40),
                const SizedBox()

              ],
            );
          }
          else{
            return const Text("No orders", style: TextStyle(fontSize: 30),);
          }
        },

    );


  }

  Widget _getOrders(BuildContext context, int index) {
    print("in get orders");
    return OrderTile(context, index,orders,true);
  }
}

