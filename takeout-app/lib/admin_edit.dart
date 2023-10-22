import 'dart:ffi';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'student_cart.dart';
import 'main.dart';

//TODO: add search ability
Map temp = {};
Map allItems = {};
Map displayItems = {};
var _search = TextEditingController();

Map limits = {};
Map placedOrders = {};
var doneOnce = false;
var documents = [
  'IppA94yUj2wrIzawr5Al',
  'GoeTLas8A4sj29bRuyw2',
  'JypyeLKmIyhEXlLebvHk',
  'NvUFdn08oieSPYfLQkU9',
  'YToUal6YkEc8XWndizBU'
];

var collections = ['everyday', 'week 1', 'week 2', 'week 3', 'week 4'];

var everydayCategories = ['Grille', 'Panini', 'Slice of Life'];

var weekCategories = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Panini'
];

var dayCategories = ['Comfort Food', 'Mindful', 'Sides'];

var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

Future<dynamic> getAllItems() async {
  print("in getAllItems");
  await FirebaseFirestore.instance
      .collection('everyday')
      .doc("IppA94yUj2wrIzawr5Al")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      if(documentSnapshot.data()==null){
        temp = {};
      }
      else{
        temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      }
      for (int i = 0; i < temp.length; i++) {
        Map currentCategory = temp.values.elementAt(i);
        for (int j = 0; j < currentCategory.length; j++) {
          String key = currentCategory.keys.elementAt(j);
          String collection = "everyday";
          String category = temp.keys.elementAt(i);
          var price = currentCategory.values.elementAt(j);
          var data = [collection, category, price];
          allItems[key] = data;
        }
      }
    } else {
      print('Document does not exist on the database');
    }
  });
  await FirebaseFirestore.instance
      .collection('week 1')
      .doc("GoeTLas8A4sj29bRuyw2")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for (int i = 0; i < temp.length; i++) {
        var currentCategory = temp.values.elementAt(i);

        if (temp.keys.elementAt(i) == 'Panini') {
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 1';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection, category, price];
        } else if (temp.keys.elementAt(i) == 'Soup') {
          for (int j = 0; j < currentCategory.length; j++) {
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 1';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for (int k = 0; k < soup.length; k++) {
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        } else {
          for (int j = 0; j < currentCategory.length; j++) {
            String collection = 'week 1';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for (int k = 0;
                k < currentCategory.values.elementAt(j).length;
                k++) {
              String key =
                  currentCategory.values.elementAt(j).keys.elementAt(k);
              var price =
                  currentCategory.values.elementAt(j).values.elementAt(k);
              allItems[key] = [collection, category, tag, price];
            }
          }
        }
      }
    } else {
      print('Document does not exist on the database');
    }

    print("week 1");
  });
  await FirebaseFirestore.instance
      .collection('week 2')
      .doc("JypyeLKmIyhEXlLebvHk")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for (int i = 0; i < temp.length; i++) {
        var currentCategory = temp.values.elementAt(i);
        if (temp.keys.elementAt(i) == 'Panini') {
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 2';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection, category, price];
        } else if (temp.keys.elementAt(i) == 'Soup') {
          for (int j = 0; j < currentCategory.length; j++) {
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 2';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for (int k = 0; k < soup.length; k++) {
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        } else {
          for (int j = 0; j < currentCategory.length; j++) {
            String collection = 'week 2';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for (int k = 0;
                k < currentCategory.values.elementAt(j).length;
                k++) {
              String key =
                  currentCategory.values.elementAt(j).keys.elementAt(k);
              var price =
                  currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key "] = [collection, category, tag, price];
            }
          }
        }
      }
    } else {
      print('Document does not exist on the database');
    }

    print("done with 2");
  });
  await FirebaseFirestore.instance
      .collection('week 3')
      .doc("NvUFdn08oieSPYfLQkU9")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for (int i = 0; i < temp.length; i++) {
        var currentCategory = temp.values.elementAt(i);

        if (temp.keys.elementAt(i) == 'Panini') {
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 3';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection, category, price];
        } else if (temp.keys.elementAt(i) == 'Soup') {
          for (int j = 0; j < currentCategory.length; j++) {
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 3';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for (int k = 0; k < soup.length; k++) {
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        } else {
          for (int j = 0; j < currentCategory.length; j++) {
            String collection = 'week 3';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for (int k = 0;
                k < currentCategory.values.elementAt(j).length;
                k++) {
              String key =
                  currentCategory.values.elementAt(j).keys.elementAt(k);
              var price =
                  currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key  "] = [collection, category, tag, price];
            }
          }
        }
      }
    } else {
      print('Document does not exist on the database');
    }

    print("done with 3");
  });
  await FirebaseFirestore.instance
      .collection('week 4')
      .doc("YToUal6YkEc8XWndizBU")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for (int i = 0; i < temp.length; i++) {
        var currentCategory = temp.values.elementAt(i);

        if (temp.keys.elementAt(i) == 'Panini') {
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 4';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection, category, price];
        } else if (temp.keys.elementAt(i) == 'Soup') {
          for (int j = 0; j < currentCategory.length; j++) {
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 4';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for (int k = 0; k < soup.length; k++) {
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        } else {
          for (int j = 0; j < currentCategory.length; j++) {
            String collection = 'week 4';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for (int k = 0;
                k < currentCategory.values.elementAt(j).length;
                k++) {
              String key =
                  currentCategory.values.elementAt(j).keys.elementAt(k);
              var price =
                  currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key   "] = [collection, category, tag, price];
            }
          }
        }
      }
      print('week 4');
    } else {
      print('Document does not exist on the database');
    }


  });

  await FirebaseFirestore.instance
      .collection('orders')
      .doc("limits")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      limits = documentSnapshot.data() as Map<dynamic, dynamic>;
      print("limit");
      print(limits.toString());
    } else {
      print('Document does not exist on the database');
    }
  });
  await FirebaseFirestore.instance
      .collection('orders')
      .doc("placed")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      placedOrders = documentSnapshot.data() as Map<dynamic, dynamic>;
      print("placedorders done");
    } else {
      print('Document does not exist on the database');
    }
  });
  if(!doneOnce){
    displayItems = allItems;
    doneOnce=true;
  }

  return allItems;
}

class EditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {

  @override
  void initState() {
    // TODO: implement initState
    _search.text = "";
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllItems(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            allItems = snapshot.data;
            print("display items");
            print(displayItems);
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 40,
                      width: 380,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _search,
                          onFieldSubmitted: (_search) {
                            print(_search.toString());
                          },
                          onChanged: (_search) {
                            setState(() {
                              _getSearchedList(_search);
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search for an item',
                            labelStyle: TextStyle(color: Colors.greenAccent),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      )),
                ),
                Expanded(
                    child: ListView.builder(
                      itemBuilder: getItemCard,
                      itemCount: displayItems.length,
                    ))
              ],
            );
          }
          else{
            return CircularProgressIndicator();
          }
        }
    );

  }

  Widget getItemCard(BuildContext context, int index) {

    return ItemCard(context, index);
  }

  void _getSearchedList(String s) {
    displayItems = {};
    for (int i = 0; i < allItems.length; i++) {
      if (allItems.keys.elementAt(i).toUpperCase().contains(s.toUpperCase())) {
        displayItems[allItems.keys.elementAt(i)] = allItems.values.elementAt(i);
      }
    }

    print(displayItems.toString());
  }
}

class ItemCard extends StatefulWidget {
  BuildContext context;
  int index;

  ItemCard(this.context, this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemCard(context, index);
  }
}

class _ItemCard extends State<ItemCard> {
  BuildContext context;
  int index;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ItemCard(this.context, this.index);

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    List itemData = displayItems.values.elementAt(index);
    return Card(
        child: ListTile(
      title: Text(displayItems.keys.elementAt(index)),
      subtitle: Text(itemData[0]),
      trailing: Container(
        width: 144,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  setLimit(index);
                },
                icon: Icon(Icons.production_quantity_limits)),
            IconButton(
                onPressed: () {
                  if (itemData[1] == 'Soup') {
                    _editSoupDialog(index);
                  } else {
                    _editItemDialog(index);
                  }
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  if (itemData[1] == 'Soup') {
                    _deleteItemDialog(index);
                  } else {
                    _deleteItemDialog(index);
                  }
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    ));
  }

  Future<void> _deleteItemDialog(int i) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete item ${displayItems.keys.elementAt(i)}?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Deleting this item will remove it permanently'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Deny'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Approve',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                print("in approve for delete");
                _deleteItemLogic(i);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSoupDialog(int i) async {
    TextEditingController _nameController = TextEditingController();
    _nameController.text = displayItems.keys.elementAt(i);
    TextEditingController _priceController = TextEditingController();
    _priceController.text =
        displayItems.values.elementAt(i).last.toStringAsFixed(2);
    Map sizes = {};
    String collectionsValue = displayItems.values.elementAt(i)[0];
    print("sizes in dialog");
    for (int j = 2; j < displayItems.values.elementAt(i).length - 1; j += 2) {
      TextEditingController key = TextEditingController();
      TextEditingController value = TextEditingController();
      value.text = displayItems.values.elementAt(i)[j + 1].toStringAsFixed(2);
      key.text = int.parse(displayItems.values
              .elementAt(i)[j]
              .replaceAll(RegExp('[^0-9]'), ''))
          .toString();

      print(key.text.toString());
      print(value.text.toString());
      sizes[key] = value;
    }
    print(sizes.toString());
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 200,
              width: 400,
              child: AlertDialog(
                title: Text("Editing item"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  labelText: "Item name: ",
                                  prefixIcon: Icon(Icons.abc)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 100,
                              width: 300,
                              child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text("size: "),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                sizes.keys.elementAt(index),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Empty field";
                                              } else if (int.tryParse(value) ==
                                                  null) {
                                                return "Not a size";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        Text('oz.'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text("price: \$"),
                                        Expanded(
                                            child: TextFormField(
                                          controller:
                                              sizes.values.elementAt(index),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Empty field";
                                            } else if (double.tryParse(value) ==
                                                null) {
                                              return "Not a price";
                                            } else {
                                              var priceNumber = double.parse(
                                                  sizes.values
                                                      .elementAt(index)
                                                      .text);
                                              print("price number");
                                              print(priceNumber.toString());
                                              priceNumber = ((priceNumber * 100)
                                                      .round()) /
                                                  100;
                                              sizes.values
                                                      .elementAt(index)
                                                      .text =
                                                  priceNumber.toString();
                                              return null;
                                            }
                                          },
                                        ))
                                      ],
                                    );
                                  }),
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Availability')),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: collectionsValue,
                                    elevation: 16,
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.

                                      s(() {
                                        collectionsValue = value!;
                                      });
                                    },
                                    items: collections
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )
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
                          String document = '';
                          for (int j = 0; j < collections.length; j++) {
                            if (collectionsValue == collections[j]) {
                              document = documents[j];
                            }
                          }
                          for (int j = 0; j < sizes.length; j++) {
                            FirebaseFirestore.instance
                                .collection(collectionsValue)
                                .doc(document)
                                .update({
                              'Soup.${_nameController.text}.${sizes.keys.elementAt(j).text + " oz"}':
                                  double.parse(sizes.values.elementAt(j).text)
                            }).then((value) => null);
                            await _deleteItemLogic(i);

                            String newKey = _nameController.text.toString();

                            double.parse(_priceController.text.toString());

                            allItems.remove(displayItems.keys.elementAt(i));
                            displayItems.remove(displayItems.keys.elementAt(i));

                            List data = [collectionsValue, 'Soup'];
                            for (int j = 0; j < sizes.length; j++) {
                              data.add(sizes.keys.elementAt(j).text);
                              data.add(sizes.values.elementAt(j).text);
                            }
                            allItems[newKey] = data;
                          }
                        }
                      },
                      child: Text('Confirm'))
                ],
              ),
            );
          });
        });
  }

  Future<void> _editItemDialog(int i) async {
    String collectionsValue = displayItems.values.elementAt(i)[0];
    TextEditingController _nameController = TextEditingController();
    _nameController.text = displayItems.keys.elementAt(i);
    TextEditingController _priceController = TextEditingController();
    _priceController.text =
        displayItems.values.elementAt(i).last.toStringAsFixed(2);
    String everydayCategoryValue;
    String weeklyCategoryValue;
    String dayCategoryValue;
    if (collectionsValue == 'everyday') {
      everydayCategoryValue = displayItems.values.elementAt(i)[1];
      weeklyCategoryValue = weekCategories.first;
      dayCategoryValue = dayCategories.first;
    } else {
      weeklyCategoryValue = displayItems.values.elementAt(i)[1];
      everydayCategoryValue = everydayCategories.first;
      dayCategoryValue = displayItems.values.elementAt(i)[2];
    }

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title: Text("Editing ${displayItems.keys.elementAt(i)}?"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText: "Item name: ",
                                  prefixIcon: Icon(Icons.abc)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                                controller: _priceController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a valid price";
                                  } else if (double.tryParse(value) == null) {
                                    return "Please make sure the price is a number";
                                  } else {
                                    var priceNumber =
                                        double.parse(_priceController.text);
                                    priceNumber =
                                        (priceNumber * 100).round() / 100;
                                    _priceController.text =
                                        priceNumber.toString();
                                    print(priceNumber);
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    labelText: "Item price",
                                    prefixIcon:
                                        Icon(Icons.monetization_on_rounded))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: Text('Availability')),
                          Expanded(
                            child: DropdownButton<String>(
                              value: collectionsValue,
                              elevation: 16,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.

                                s(() {
                                  collectionsValue = value!;
                                });
                              },
                              items: collections.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      if (collectionsValue == 'everyday')
                        Row(
                          children: [
                            Expanded(child: Text("Category")),
                            Expanded(
                              child: DropdownButton<String>(
                                value: everydayCategoryValue,
                                elevation: 16,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  s(() {
                                    everydayCategoryValue = value!;
                                  });
                                },
                                items: everydayCategories
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      if (collectionsValue != 'everyday')
                        Row(
                          children: [
                            const Expanded(child: Text('Day: ')),
                            Expanded(
                              child: DropdownButton<String>(
                                value: weeklyCategoryValue,
                                elevation: 16,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  s(() {
                                    weeklyCategoryValue = value!;
                                  });
                                },
                                items: weekCategories
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      if (weeklyCategoryValue != 'Panini' &&
                          collectionsValue != 'everyday')
                        Row(
                          children: [
                            Expanded(
                              child: Text('Category: '),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                value: dayCategoryValue,
                                elevation: 16,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  s(() {
                                    dayCategoryValue = value!;
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
                            )
                          ],
                        )
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          if (collectionsValue == 'everyday') {
                            FirebaseFirestore.instance
                                .collection('everyday')
                                .doc('IppA94yUj2wrIzawr5Al')
                                .update({
                              '$everydayCategoryValue.${_nameController.text.toString()}':
                                  double.parse(_priceController.text.toString())
                            }).then((value) => null);



                            String newKey = _nameController.text.toString();
                            double newPrice =
                                double.parse(_priceController.text.toString());

                            allItems.remove(displayItems.keys.elementAt(i));
                            displayItems.remove(displayItems.keys.elementAt(i));
                            allItems[newKey] = [
                              collectionsValue,
                              everydayCategoryValue,
                              newPrice
                            ];
                          } else {
                            String document = '';
                            for (int j = 0; j < collections.length; j++) {
                              if (collections[j] == collectionsValue) {
                                document = documents[j];
                              }
                            }
                            if (weeklyCategoryValue == 'Panini') {
                              FirebaseFirestore.instance
                                  .collection(collectionsValue)
                                  .doc(document)
                                  .update({
                                '$weeklyCategoryValue.${_nameController.text.toString()}':
                                    double.parse(
                                        _priceController.text.toString())
                              }).then((value) => null);
                              
                              String newKey = _nameController.text.toString();
                              double newPrice = double.parse(
                                  _priceController.text.toString());
                              allItems.remove(displayItems.keys.elementAt(i));
                              displayItems
                                  .remove(displayItems.keys.elementAt(i));
                              allItems[newKey] = [
                                collectionsValue,
                                weeklyCategoryValue,
                                newPrice
                              ];
                            } else {
                              FirebaseFirestore.instance
                                  .collection(collectionsValue)
                                  .doc(document)
                                  .update({
                                '$weeklyCategoryValue.$dayCategoryValue.${_nameController.text.toString()}':
                                    double.parse(
                                        _priceController.text.toString())
                              }).then((value) => null);

                              String newKey = _nameController.text.toString();
                              double newPrice = double.parse(
                                  _priceController.text.toString());

                              allItems.remove(displayItems.keys.elementAt(i));
                              displayItems
                                  .remove(displayItems.keys.elementAt(i));
                              allItems[newKey] = [
                                collectionsValue,
                                weeklyCategoryValue,
                                dayCategoryValue,
                                newPrice
                              ];
                            }
                          }
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Confirm'))
                ],
              ),
            );
          });
        });
  }

  Future<void> _deleteItemLogic(int i) async {
    List itemData = displayItems.values.elementAt(i);
    int docIndex = 0;
    for (int j = 0; j < collections.length; j++) {
      if (collections[j] == itemData[0]) {
        docIndex = j;
        break;
      }
    }
    if (itemData.length == 3 || itemData[1] == 'Soup') {
      await FirebaseFirestore.instance
          .collection(displayItems.values.elementAt(i)[0])
          .doc(documents[docIndex])
          .update({
        '${itemData[1]}.${displayItems.keys.elementAt(i)}': FieldValue.delete()
      }).whenComplete(() {
        print('Field Deleted');
      });
      print("done with delete");
      setState(() {
        allItems.remove(displayItems.keys.elementAt(i));
        displayItems.remove(displayItems.keys.elementAt(i));
      });
    } else if (itemData.length == 4) {
      String key = displayItems.keys.elementAt(i).trim();
      print("key");
      await FirebaseFirestore.instance
          .collection(displayItems.values.elementAt(i)[0])
          .doc(documents[docIndex])
          .update({
        '${itemData[1]}.${itemData[2]}.$key': FieldValue.delete()
      }).whenComplete(() {
        print('Field Deleted');
      });
      print("done with delete");
      setState(() {
        allItems.remove(displayItems.keys.elementAt(i));
        displayItems.remove(displayItems.keys.elementAt(i));
      });
    } else {}
  }

  Future<void> setLimit(int i) async {
    TextEditingController limit = TextEditingController();
    TextEditingController large = TextEditingController();
    TextEditingController small = TextEditingController();
    List itemData = displayItems.values.elementAt(i);

    var placed;
    print("in set limit");
    print(placedOrders);
    var currentLimit;
    if (limits.containsKey(displayItems.keys.elementAt(i))) {
      print("limits");
      print(limits.toString());
      currentLimit = limits[displayItems.keys.elementAt(i)];
    }
    print("currentlimit");
    print(currentLimit);
    if(placedOrders.containsKey(displayItems.keys.elementAt(i))){
      placed = placedOrders[displayItems.keys.elementAt(i)];
    }

    if (currentLimit != null) {
      if(currentLimit.runtimeType != Map){
        limit.text = currentLimit.toString();

      }
      else{
        int l = currentLimit[0];
        int s = currentLimit[1];

        if(l!=0){
          large.text = l.toString();
        }
        if(s!=0){
          small.text = s.toString();
        }
      }
    }
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title:
                    Text("Adding limit for ${displayItems.keys.elementAt(i)}"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                if (itemData[1] == 'Soup')
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        if(placed != null && placed.containsKey('large'))
                                          Text('${placed['large']} large soups ordered'),
                                        if(placed != null && placed.containsKey('small'))
                                          Text('${placed['small']} small soups ordered'),
                                        Row(
                                          children: [
                                            const Expanded(child: Text("Large:")),
                                            Expanded(
                                              child: TextFormField(
                                                controller: large,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      int.tryParse(value) ==
                                                          false) {
                                                    return "Please enter a valid number";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(child: Text("Small:")),
                                            Expanded(
                                              child: TextFormField(
                                                controller: small,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      int.tryParse(value) ==
                                                          false) {
                                                    return "Please enter a valid number";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                if (itemData[1] != 'Soup')
                                  Container(
                                    height: 80,
                                    width: 200,
                                    child: Column(
                                      children: [
                                        if (placed != null)
                                          Expanded(
                                              child: placed != 1? Text(
                                                  "$placed orders have been placed"):Text("1 order has been placed")),

                                        Expanded(
                                            child: Row(
                                          children: [
                                            Expanded(child: Text("Limit: ")),
                                            Expanded(
                                              child: TextFormField(
                                                controller: limit,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Add a limit"),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      int.tryParse(value) == null) {
                                                    return "Invalid number";
                                                  }
                                                  else if(placed==null){
                                                    return null;
                                                  }
                                                  else if(int.parse(value)<placed){
                                                    return "Limit less than orders placed";
                                                  }


                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(itemData);
                          if (itemData[1] == 'Soup') {
                              if(int.parse(large.text)!=0){
                                FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc('limits')
                                    .update({
                                  "${displayItems.keys.elementAt(i)}.large": int.parse(large.text)
                                }).then((value) => null);
                              }
                              if(int.parse(small.text)!=0){
                                FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc('limits')
                                    .update({
                                  "${displayItems.keys.elementAt(i)}.small": int.parse(small.text)
                                }).then((value) => null);
                              }

                              List soupLimit = [int.parse(large.text),int.parse(small.text)];
                              limits[displayItems.keys.elementAt(i)] = soupLimit;

                          } else {

                              FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc('limits')
                                  .update({
                                displayItems.keys.elementAt(i): int.parse(limit.text)
                              }).then((value) => null);

                              limits[displayItems.keys.elementAt(i)] = int.parse(limit.text);


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
