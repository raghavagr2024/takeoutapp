import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'student_confirmation.dart';
import 'student_home.dart';

import 'student_checkout.dart';
import 'main.dart';
import 'order_class.dart';

var periods = [
  "4A (11:10 - 11:30)",
  "4B (11:37 - 11:57)",
  "5A (12:02-12:22)",
  "5B (12:02 - 12:22)",
  "6A (12:45 - 1:14)"
];

var total = 0;
var locations = ["East Commons", "West Commons"];
var paymentOptions = ["Pay online"];
var preferences = [periods.first, locations.first, paymentOptions.first];
List meats = [
  "Chicken",
  "Gyro",
  "Italian Sausage",
  "Meatballs",
  "Barbacoa",
  "BBQ Chicken",
  "Bacon Bits"
];

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    print("in cart");
    print(selected.length);
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: BackButton(),
          ),
          SizedBox(
            height: (selected.length + 1) * (55),
            child: Align(
              alignment: Alignment.topCenter,
              child: ItemList(),
            ),
          ),
          SizedBox(
            height: (selectedSoups.length + 1) * (50),
            child: Align(
              alignment: Alignment.topCenter,
              child: SoupList(),
            ),
          ),
          TotalPrice(),
          PeriodButton(),
          const SizedBox(
            height: 5,
          ),
          LocationButton(),
          const SizedBox(
            height: 5,
          ),
          Payment(),
          NextButton()
        ],
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  State<ItemList> createState() => _ItemList();
}

class _ItemList extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: selected.length,
        itemBuilder: _getSelectedItems,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 0,
        ));
  }

  Widget _getSelectedItems(BuildContext context, int index) {
    return ItemTile(context, index);
  }
}

class PeriodButton extends StatefulWidget {
  @override
  State<PeriodButton> createState() => _PeriodButton();
}

class _PeriodButton extends State<PeriodButton> {
  var value = preferences[0];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 37,
        ),
        const Text(
          "Time",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[0] = value;
            });
          },
          items: periods.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }
}

class LocationButton extends StatefulWidget {
  @override
  State<LocationButton> createState() => _LocationButton();
}

class _LocationButton extends State<LocationButton> {
  var value = preferences[1];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 37,
        ),
        const Text(
          "Location: ",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[1] = value;
            });
          },
          items: locations.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }
}

class Payment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Payment();
  }
}

class _Payment extends State<Payment> {
  var value = preferences[2];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 37,
        ),
        const Text(
          "Payment option: ",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[2] = value;
            });
          },
          items: paymentOptions.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }
}

class ItemTile extends StatelessWidget {
  BuildContext context;

  int index;

  ItemTile(this.context, this.index);

  Widget build(context) {
    print("in item tile");
    print(selected.keys.elementAt(index));
    return Container(
        height: 53,
        child: ListTile(
          title: Item(index),
        ));
  }
}

class Item extends StatefulWidget {
  var index;

  Item(this.index);

  @override
  State<StatefulWidget> createState() {
    return _Item(index);
  }
}

class _Item extends State<Item> {
  var index;

  _Item(this.index);

  var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    String ans = format.format(selected.values.elementAt(index)[1] *
        selected.values.elementAt(index)[0]);

    return Row(
      children: <Widget>[
        const SizedBox(width: 20),
        Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Text(
                    selected.values.elementAt(index)[0].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        selected.remove(selected.keys.elementAt(index));
                        print(selected.toString());
                        if (selected.isEmpty) {
                          print("in null");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Cart()),
                                (Route<dynamic> route) => false,
                          );
                        }
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _displayInfo(context, index);
                },
                child: Text(selected.keys.elementAt(index),
                    style: const TextStyle(fontSize: 15)),
              )),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(ans, style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  Future<void> _displayInfo(BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selected.keys.elementAt(index)),
          content: CounterButton(index),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: const Text("done"))
          ],
        );
      },
    );
  }
}

class CounterButton extends StatefulWidget {
  var index;

  CounterButton(
      this.index,
      );

  @override
  State<StatefulWidget> createState() {
    return _CounterButton(index);
  }
}

class _CounterButton extends State<CounterButton> {
  var index;

  _CounterButton(this.index);

  @override
  Widget build(BuildContext context) {
    var text = selected.values.elementAt(index)[0];

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: text != 1 ? const Color(0xFFc99a2c) : Colors.grey,
              size: 20,
            ),
            onPressed: text != 1 ? () => subtract(index) : null,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
            child: Text(
              text.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle,
                color: Color(0xFFc99a2c), size: 20),
            onPressed: () {
              add(index);
            },
          ),
        ],
      ),
    );
  }

  void subtract(var i) {
    selected.values.elementAt(i)[0]--;

    print(selected.toString());
    setState(() {});
  }

  void add(var i) {
    print(selected.values.elementAt(i)[0]);
    selected.values.elementAt(i)[0]++;

    setState(() {});
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }
}

class TotalPrice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TotalPrice();
  }
}

class _TotalPrice extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "total:   ${format.format(getPrice())}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            width: 34,
          )
        ],
      ),
    );
  }


}

class SoupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SoupList();
  }
}

class _SoupList extends State<SoupList> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var soup = selectedSoups.values.elementAt(index);
        if (soup[0] != 0 && soup[1] != 0) {
          var ans = soup[0] * 2 + soup[1] * 1.5;
          return Container(
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 50,
                          child: Column(children: [
                            Text("12 oz.: ${soup[0]}", style: const TextStyle(fontSize: 20)),
                            Text("8 oz.: ${soup[1]}", style: const TextStyle(fontSize: 20))
                          ]),
                        ),
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(selectedSoups.keys.elementAt(index),
                            style: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          _showSoupDialog(index);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child:
                      Text(format.format(ans), style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 25),
                ],
              ));
        } else if (soup[0] == 0 && soup[1] != 0) {
          var ans = soup[0] * 2 + soup[1] * 1.5;

          return Container(
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("8 oz.: ${soup[1]}",
                              style: const TextStyle(fontSize: 20)))),

                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(selectedSoups.keys.elementAt(index),
                            style: const TextStyle(fontSize: 15)),
                        onPressed: () { _showSoupDialog(index);},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(format.format(ans),
                            style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 35),
                ],
              ));
        } else {
          var ans = soup[0] * 2 + soup[1] * 1.5;

          return Container(
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("12 oz.: ${soup[0]}",
                              style: const TextStyle(fontSize: 20)))),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(selectedSoups.keys.elementAt(index),
                            style: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          _showSoupDialog(index);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(format.format(ans),
                            style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 25),
                ],
              ));
        }
      },
      itemCount: selectedSoups.length,
    );
  }

  Future<void> _showSoupDialog(int i) async {
    print("in show soup dialog");
    var soup = {};
    if(selectedSoups.keys.elementAt(i)==weeklyItems['Soup'].keys.elementAt(0)){


      soup = {soup1.keys.elementAt(0):[soup1.values.elementAt(0)[0],soup1.values.elementAt(0)[1]]};

    }
    else{

      soup = {soup2.keys.elementAt(0):[soup2.values.elementAt(0)[0],soup2.values.elementAt(0)[1]]};

    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          for(int i = 0;i<100;i++){
            count.add("$i");
          }
          return StatefulBuilder(builder: (context,s){
            return Container(
                height: 700,
                width: 320,
                child: AlertDialog(
                  title: Text(selectedSoups.keys.elementAt(i)),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Tooltip(
                                message: "Size: 12 oz.\nPrice: \$2.00",
                                child: Text("L: "),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                  child: DropdownButton2<String>(
                                    value: soup.values.elementAt(0)[0].toString(),
                                    dropdownMaxHeight: 250,
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      s((){
                                        soup.values.elementAt(0)[0] = int.parse(value!);
                                        if(getPrice()==0){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomePage()));
                                        }
                                      });

                                    },
                                    items: count.map<DropdownMenuItem<String>>((var value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Tooltip(
                                message: "Size: 8 oz.\nPrice: \$1.50",
                                child: Text("S: "),
                              ),
                              Container(
                                  child: DropdownButton2<String>(
                                    dropdownMaxHeight: 250,
                                    value: soup.values.elementAt(0)[1].toString(),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.

                                      s((){
                                        soup.values.elementAt(0)[1] = int.parse(value!);
                                        if(getPrice()==0){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomePage()));
                                        }
                                      });
                                    },
                                    items: count.map<DropdownMenuItem<String>>((var value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if(soup.keys.elementAt(0)==soup1.keys.elementAt(0)){
                            soup1[soup1.keys.elementAt(0)] = [0,0];
                          }
                          else{
                            soup1[soup1.keys.elementAt(0)] = [0,0];
                          }

                          selectedSoups.remove(soup.keys.elementAt(0));
                        });

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    TextButton(
                        onPressed: (){

                          Navigator.of(context).pop();
                        },
                        child: const Text("cancel")
                    ),
                    TextButton(
                        onPressed: (){

                          setState((){
                            if(soup.keys.elementAt(0)==soup1.keys.elementAt(0)){
                              soup1[soup1.keys.elementAt(0)] = soup[soup.keys.elementAt(0)];
                              selectedSoups[soup1.keys.elementAt(0)] = soup1[soup1.keys.elementAt(0)];
                              if(soup.values.elementAt(0)[0]==0 && soup.values.elementAt(0)[1]==0){
                                selectedSoups.remove(soup.keys.elementAt(0));
                              }
                            }
                            else{
                              soup2[soup2.keys.elementAt(0)] = soup[soup.keys.elementAt(0)];
                              selectedSoups[soup2.keys.elementAt(0)] = soup2[soup2.keys.elementAt(0)];
                              if(soup.values.elementAt(0)[0]==0 && soup.values.elementAt(0)[1]==0){
                                selectedSoups.remove(soup.keys.elementAt(0));
                              }
                            }

                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                        child: const Text("confirm")
                    )
                  ],

                )
            );}
          );
        });
  }
}

class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement firebase calls
    return TextButton(
        onPressed: () {
          var order = Order(selected, selectedSoups, preferences[0],
              preferences[1], preferences[2]);
          order.addOrder();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ConfirmationPage()));
        },
        child: const Text("Continue"));
  }
}

double getPrice() {
  double total = 0;
  for (int i = 0; i < selected.length; i++) {
    total +=
        selected.values.elementAt(i)[0] * selected.values.elementAt(i)[1];
  }

  for (int i = 0; i < selectedSoups.length; i++) {
    total += selectedSoups.values.elementAt(i)[0] * 2 +
        selectedSoups.values.elementAt(i)[1] * 1.5;
  }

  return total;
}