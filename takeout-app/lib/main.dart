


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admin_home_page.dart';
import 'admin_login_page.dart';
import 'admin_order.dart';
import 'first_page.dart';
import 'order_class.dart';
//TODO: Migrate from realtime database to cloud firestore
Map<String, dynamic> everyDayItems = {};
Map selected = {};
Map orders = {};
Map selectedSoups = {};
var soup1 = {};
var soup2 = {};
bool initDone = false;
Map<String, dynamic> weeklyItems = {};
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0,),
        body: FirstPage()
      ),
    );

  }
}

class OrderTile extends StatefulWidget {
  BuildContext context;
  int index;
  Map temp;
  bool admin;
  OrderTile(this.context, this.index, this.temp, this.admin);

  @override
  State<StatefulWidget> createState() {
    return _OrderTile(context, index, temp,admin);
  }
}

class _OrderTile extends State<OrderTile> {
  BuildContext context;

  int index;
  Map temp;
  bool admin;
  Map values = {};
  String orderId = "";
  _OrderTile(this.context, this.index, this.temp, this.admin);

  Widget build(context) {

    values = temp.values.elementAt(index);
    orderId = temp.keys.elementAt(index);
    print(values);
    print("values");
    print(temp);
    print("temp");
    Map foods = values['foods'];
    Map soups = values['soups'];
    // values.remove('foods');
    // values.remove('soups');
    String current = "";

    for (var i = 0; i < values.length - 1; i++) {
      if(values.keys.elementAtOrNull(i)=='foods'||values.keys.elementAtOrNull(i)=='soups'){
        continue;
      }
      current += values.keys.elementAt(i) +
          ":    " +
          values.values.elementAt(i) +
          "\n";
    }
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    if(foods==null){
      current +="";
    }
    else{
      current += "foods: \n";
      for(int i = 0; i<foods.length;i++){
        if(values.keys.elementAtOrNull(i)=='foods'||values.keys.elementAtOrNull(i)=='soups'){
          continue;
        }
        current += "${foods.values.elementAt(i)[0]}   ${foods.keys.elementAt(i)}:   ${format.format(foods.values.elementAt(i)[0]*foods.values.elementAt(i)[1])}\n";
      }
    }
    if(soups==null){
      current+="";
    }
    else{
      current += "Soups: \n";
      for(int i = 0; i<soups.length;i++){
        if(values.keys.elementAtOrNull(i)=='foods'||values.keys.elementAtOrNull(i)=='soups'){
          continue;
        }
        if(soups.values.elementAt(i)[0]!=0){
          current += "${soups.values.elementAt(i)[0]}   12 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[0]*2)}\n";
        }
        if(soups.values.elementAt(i)[1]!=0){
          current += "${soups.values.elementAt(i)[1]}   8 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[1]*1.5)}\n";
        }
      }
    }
    return Card(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                'Order id: $orderId',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(current),
                trailing: admin?IconButton(
                  onPressed: (){
                    deleteOrderDialog(index);
                  },
                  icon: Icon(Icons.highlight_remove_outlined),
                ):null,
              )

            ],
          ),
        ));
  }

  Future<void> deleteOrderDialog(int i) async {

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title: Text("Deleting order for order ID :${orderId}"),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("Deleting this order will clear it from the list")
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")
                  ),
                  TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('SxHI0lmZHaO8r2BnwtuH')
                            .update({
                          orderId: FieldValue.delete()
                        }).whenComplete(() {
                          print('Field Deleted');
                        });
                        print("done with delete");

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminPage()));

                      },
                      child: Text("Confirm")
                  ),

                ],
              ),
            );
          });
        });
  }

}



