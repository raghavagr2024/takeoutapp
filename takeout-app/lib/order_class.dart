import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order {
  Map foods;
  String orderTime;
  String orderLocation;
  String paymentMethod;
  int id = 0;
  Map soups;
  String std = "";
  Order(this.foods, this.soups, this.orderTime, this.orderLocation,
      this.paymentMethod);

  Future<void> addOrder() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print("in add order");
    print(soups.toString());
    addCount();

    await FirebaseFirestore.instance
        .collection('orders')
        .doc('users')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        id = (documentSnapshot.data() as Map<dynamic,dynamic>)['ordered'] + 10000;
      } else {
        print('Document does not exist on the database');
      }
    });
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
          std = temp[key]['com'];
        }
        else{
          print("Fatal Error: user does not exist");
        }

      } else {
        print('Document does not exist on the database');
      }
    });
    print("sucessful");

    incrementOrdered();
    return users
        .doc("SxHI0lmZHaO8r2BnwtuH/")
        .update({
          id.toString(): {
            "foods": foods,
            "soups": soups,
            "location": orderLocation,
            "time": orderTime,
            "payment method": paymentMethod,
            "student-id": std
          }
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addCount() async {
    print("in add count");
    CollectionReference ref = FirebaseFirestore.instance.collection('orders');
    Map placed = {};
    await FirebaseFirestore.instance
        .collection('orders')
        .doc("placed")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        placed = documentSnapshot.data() as Map<dynamic, dynamic>;
      } else {
        print("error occured while fetching order count");
      }
    });

    for (int i = 0; i < foods.length; i++) {
      if (placed.containsKey(foods.keys.elementAt(i))) {
        ref.doc('placed').update({
          foods.keys.elementAt(i):
              foods.values.elementAt(i)[0] + placed[foods.keys.elementAt(i)]
        });
      } else {
        ref
            .doc('placed')
            .update({foods.keys.elementAt(i): foods.values.elementAt(i)[0]});
      }
    }
    List sizes = ['large', 'small'];
    print(soups.toString());
    for (int i = 0; i < soups.length; i++) {
      for (int j = 0; j < soups.values.elementAt(i).length; j++) {
        if (soups.values.elementAt(i)[j] != 0) {
          if(placed.containsKey(soups.keys.elementAt(i))){
            if (placed[soups.keys.elementAt(i)].containsKey(sizes[j])) {
              ref.doc('placed').update({
                "${soups.keys.elementAt(i)}.${sizes[j]}":
                placed[soups.keys.elementAt(i)][sizes[j]] +
                    soups.values.elementAt(i)[j]
              });
              print("in first if");
            } else {
              ref.doc('placed').update({
                "${soups.keys.elementAt(i)}.${sizes[j]}":
                soups.values.elementAt(i)[j]
              });
              print("in if else");
            }
          }
          else{
            ref.doc('placed').update({
              "${soups.keys.elementAt(i)}.${sizes[j]}":
              soups.values.elementAt(i)[j]
            });
            print("in else else");
          }
        }

      }
    }
  }
  Future<void> incrementOrdered() async {
    CollectionReference orderId  = FirebaseFirestore.instance.collection('orders');
    orderId.doc("users").update({
      "ordered": id-9999
    }
    );
  }
}


