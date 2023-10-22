import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admin_edit.dart';

import 'admin_order.dart';
import 'admin_statistics.dart';
import 'main.dart';

Map data = {};
Future<dynamic> getData() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc("SxHI0lmZHaO8r2BnwtuH")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map<dynamic, dynamic>;

    } else {
      print('Document does not exist on the database');
    }

  });

  return data;
}
var allEverydayCategories = ['Grille', 'Panini', 'Slice of Life', 'Soup'];
var allWeeklyCategories = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Panini',
  'Soup'
];

Future<Map> getOrders() async {
  Map temp = {};
  await FirebaseFirestore.instance
      .collection('users')
      .doc("SxHI0lmZHaO8r2BnwtuH")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
       temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(orders.toString());
    } else {
      print('Document does not exist on the database');
    }
    print("done with getData");
    print(temp);
  });
  return temp;
}

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminPage();
  }
}

class _AdminPage extends State<AdminPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    print("in main page");
    return Scaffold(
      body: (_getPage()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFc99a2c),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Stats',
          )

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF1f5d39),
          onPressed: () {
            addItemDialog();
          },
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Widget _getPage() {
    print("in get page");
    getData();
    if (_selectedIndex == 0) {
      return OrderPage();
    } else if(_selectedIndex==1) {
      return EditPage();
    }
    else{
      return StatsPage();
    }

  }

  Future<void> addItemDialog() async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var itemName = TextEditingController();
    var itemPrice = TextEditingController();
    var currentCollection = collections[0];
    var currentEverydayCategory = allEverydayCategories[0];
    var currentWeeklyCategory = allWeeklyCategories[0];
    var dailyCategoryValue = dayCategories[0];

    var size1Name = TextEditingController(),
        size1Price = TextEditingController(),
        size2Name = TextEditingController(),
        size2Price = TextEditingController();

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              child: AlertDialog(
                title: Text("Adding Item"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: currentCollection,
                        elevation: 16,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.

                          s(() {
                            currentCollection = value!;
                          });
                        },
                        items: collections
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      if (currentCollection == 'everyday')
                        DropdownButton<String>(
                          value: currentEverydayCategory,
                          elevation: 16,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.

                            s(() {
                              currentEverydayCategory = value!;
                            });
                          },
                          items: allEverydayCategories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      if (currentCollection != 'everyday')
                        Expanded(
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: currentWeeklyCategory,
                                elevation: 16,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  s(() {
                                    currentWeeklyCategory = value!;
                                  });
                                },
                                items: allWeeklyCategories
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              if (currentWeeklyCategory != 'Panini' &&
                                  currentWeeklyCategory != 'Soup')
                                DropdownButton<String>(
                                  value: dailyCategoryValue,
                                  elevation: 16,
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.

                                    s(() {
                                      dailyCategoryValue = value!;
                                    });
                                  },
                                  items: dayCategories
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                      if ((currentCollection == 'everyday' &&
                              currentEverydayCategory != 'Soup') ||
                          (currentCollection != 'everyday' &&
                              currentWeeklyCategory != 'Soup'))
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Item name"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a  name";
                                  }
                                  return null;
                                },
                                controller: itemName,
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Item price"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a valid price";
                                  } else if (double.tryParse(value) == null) {
                                    return "Please make sure the price is a number";
                                  } else {
                                    var priceNumber =
                                        double.parse(itemPrice.text);
                                    priceNumber =
                                        (priceNumber * 100).round() / 100;
                                    itemPrice.text = priceNumber.toString();
                                    print(priceNumber);
                                    return null;
                                  }
                                },
                                controller: itemPrice,
                              ),
                            ],
                          ),
                        ),
                      if ((currentWeeklyCategory == 'Soup' &&
                              currentCollection != 'everyday') ||
                          (currentEverydayCategory == 'Soup' &&
                              currentCollection == 'everyday'))
                        Container(
                          height: 210,

                          child: Column(
                            children: [

                              TextFormField(
                                controller: itemName,

                                decoration: const InputDecoration(
                                  hintText: "Item name"

                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a valid name";
                                  } else {
                                    return null;
                                  }
                                },


                              ),
                                  Row(
                                children: [
                                  const Expanded(child: Text("Size:")),
                                  Expanded(
                                      child: TextFormField(
                                        controller: size1Name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                            return "Invalid";
                                          }  else {
                                            size1Name.text = int.parse(size1Name.text).toString();
                                            return null;
                                          }
                                        },
                                      ),

                                  ),
                                  Expanded(child: Text("Price:")),
                                  Expanded(
                                    child: TextFormField(
                                      controller: size1Price,
                                      validator: (value) {
                                        if (value == null || value.isEmpty || double.tryParse(value) == null) {
                                          return "Invalid";
                                        }  else {
                                          size1Price.text = double.parse(size1Price.text).toStringAsFixed(2);
                                          print(size1Price.text + "size1Price");
                                          return null;
                                        }
                                      },
                                    ),
                                  ),


                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Size:")),
                                  Expanded(
                                    child: TextFormField(
                                      controller: size2Name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                          return "Invalid";
                                        }  else {
                                          size2Name.text = int.parse(size2Name.text).toString();

                                          return null;
                                        }
                                      },
                                    ),

                                  ),

                                  Expanded(child: Text("Price:")),
                                  Expanded(
                                    child: TextFormField(
                                      controller: size2Price,
                                      validator: (value) {
                                        if (value == null || value.isEmpty || double.tryParse(value) == null) {
                                          return "Invalid";
                                        }  else {
                                          size2Price.text = double.parse(size2Price.text).toStringAsFixed(2);
                                          print(size2Price.text + "size2Price");
                                          return null;
                                        }
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () async {

            if (_formKey.currentState!.validate()) {
              if (currentCollection == 'everyday') {
                if(currentEverydayCategory=='Soup'){
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc("IppA94yUj2wrIzawr5Al")
                      .update({'Soup.${itemName.text}.${"${size1Name.text} oz"}':double.parse(size1Price.text)})
                      .whenComplete(() {
                    print("item added");
                  });
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc("IppA94yUj2wrIzawr5Al")
                      .update({
                    'Soup.${itemName.text}.${"${size2Name.text} oz"}':
                    double.parse(size2Price.text)
                  }).whenComplete(() {
                    print("item added");
                  });
                }
                else{
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc("IppA94yUj2wrIzawr5Al")
                      .update({
                    '$currentEverydayCategory.${itemName.text}':
                    double.parse(itemPrice.text)
                  }).whenComplete(() {
                    print("item added");
                  });
                }

              } else {
                String document = '';
                for (int j = 0; j < collections.length; j++) {
                  if (collections[j] == currentCollection) {
                    document = documents[j];
                  }
                }
                if (currentWeeklyCategory == 'Panini') {
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc(document)
                      .update({
                    '$currentWeeklyCategory.${itemName.text}':
                    double.parse(itemPrice.text)
                  }).whenComplete(() {
                    print("item added");
                  });
                } else if (currentWeeklyCategory != 'Soup') {
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc(document)
                      .update({
                    '$currentWeeklyCategory.$dailyCategoryValue.${itemName.text}':
                    double.parse(itemPrice.text)
                  }).whenComplete(() {
                    print("item added");
                  });
                }
                else{
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc(document)
                      .update({'Soup.${itemName.text}.${"${size1Name.text} oz"}':double.parse(size1Price.text)})
                      .whenComplete(() {
                    print("item added");
                  });
                  FirebaseFirestore.instance
                      .collection(currentCollection)
                      .doc(document)
                      .update({
                    'Soup.${itemName.text}.${"${size2Name.text} oz"}':
                    double.parse(size2Price.text)
                  }).whenComplete(() {
                    print("item added");
                  });
                }
              }

              Navigator.of(context).pop();

            }

                      },
                      child: Text("Confirm")),
                ],
              ),
            );
          });
        });
  }
}

