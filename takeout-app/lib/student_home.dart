import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'student_order_history.dart';
import 'first_page.dart';
import 'student_cart.dart';
import 'main.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


Map maxLimit = {};
Map placed = {};
class HomePage extends StatelessWidget {


  @override
  void initState(){
    FirebaseFirestore.instance
        .collection('orders')
        .doc('limits')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        maxLimit = documentSnapshot.data() as Map<dynamic,dynamic>;
      } else {
        print('Document does not exist on the database');
      }
    });
    FirebaseFirestore.instance
        .collection('orders')
        .doc('placed')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        placed = documentSnapshot.data() as Map<dynamic,dynamic>;
      } else {
        print('Document does not exist on the database');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      body: EveryDayItems(),
      drawer: Drawer(width: 200,child: Column(
        children: [
          SizedBox(height: 50,),
              ListTile(
                title: Text("View Orders"),
                leading: Icon(Icons.account_circle),
                onTap: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderHistory()));
                },
              ),
            ListTile(
              title: const Text("Create a new Order"),
              leading: const Icon(Icons.add),
              onTap: (){
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
            ),
          ListTile(
            title: const Text("Sign Out"),
            leading: const Icon(Icons.timer),
            onTap: () async {
                selectedSoups.clear();
                selected.clear();
                await FirebaseAuth.instance.signOut();
                print(FirebaseAuth.instance.currentUser);
                print("signed out");
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()));
                }
            },
          ),


        ],
      ),
      ),
    );
  }
}

String station = "";
final ValueNotifier<int> _counter = ValueNotifier<int>(0);
var count = [];

class EveryDayItems extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    CollectionReference users =
    FirebaseFirestore.instance.collection('everyday');

    String id = "IppA94yUj2wrIzawr5Al";

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error as String);
            log("got error");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            log("no data");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            log("done");
            everyDayItems = snapshot.data!.data() as Map<String, dynamic>;
          }

          try {
            log("size of screen");
            log(MediaQuery.of(context).size.height.toString());
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 60),
                  Row(
                    children:  [
                      const SizedBox(width: 10,),
                     IconButton(onPressed: (){
                       print("in icon pressed");
                       Scaffold.of(context).openDrawer();

                     }, icon: Icon(Icons.menu,size: 35,)) ,
                      const SizedBox(width: 125,),
                      const Text(
                        "Grille:",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (everyDayItems["Grille"]).length,
                      itemBuilder: _getItemsForGrille),
                  const Text(
                    "Panini:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (everyDayItems["Panini"]).length,
                      itemBuilder: _getItemsForPanini),
                  const Text(
                    "Slice of Life:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: everyDayItems["Slice of Life"].length,
                      itemBuilder: _getItemsForSliceOfLife),
                  SizedBox(height: 1100, child: WeekItems()),
                ],
              ),
            );
          } catch (noSuchMethodError) {
            log("test");
          }
          return const SizedBox(height: 0);
        });
  }

  Widget _getItemsForGrille(BuildContext context, int index) {
    return Tile(context, everyDayItems['Grille'], index);
  }

  Widget _getItemsForPanini(BuildContext context, int index) {
    return Tile(context, everyDayItems['Panini'], index);
  }

  Widget _getItemsForSliceOfLife(BuildContext context, int index) {
    return Tile(context, everyDayItems['Slice of Life'], index);
  }
}

class WeekItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var week = getWeek()[0];
    var id = getWeek()[1];
    station = getStation();
    log("in week items");
    log("soup 1");
    log(soup1.toString());
    log("soup 2");
    log(soup2.toString());
    CollectionReference users = FirebaseFirestore.instance.collection(week);

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            log("following error");
            log(snapshot.error as String);
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            log("no data");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            log("done");
            weeklyItems = snapshot.data!.data() as Map<String, dynamic>;

            log(weeklyItems[getDay()].length.toString());
            log(weeklyItems['Soup'].toString());
          }

          try {
            return Scaffold(
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Text(
                        getDay(),
                        style: const TextStyle(fontSize: 30),
                      ),
                      const Text(
                        "Comfort",
                        style: TextStyle(fontSize: 30),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()].values.elementAt(0).length,
                          itemBuilder: _getComfort),
                      const Text(
                        "Mindful",
                        style: TextStyle(fontSize: 30),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()].values.elementAt(1).length,
                          itemBuilder: _getMindful),
                      const Text(
                        "Sides",
                        style: TextStyle(fontSize: 30),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()].values.elementAt(2).length,
                          itemBuilder: _getSides),
                      const Text(
                        "Panini:",
                        style: TextStyle(fontSize: 30),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems["Panini"].length,
                          itemBuilder: _getPanini),
                      const Text(
                        "Soups: ",
                        style: TextStyle(fontSize: 30),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems["Soup"].length,
                          itemBuilder: (BuildContext context, int index) {
                            Map soups = weeklyItems['Soup'];
                            return Card(
                                child: ListTile(
                                    title: Text(soups.keys.elementAt(index)),
                                    trailing: SoupTrailer(index, soups)
                                )
                            );
                          }),
                      NextButton()
                    ],
                  ),
                ));
          } catch (NoSuchMethodError) {
            log("test");
          }

          return const Text("None");
        });
  }

  Widget _getPanini(BuildContext context, int index) {
    return Tile(context, weeklyItems['Panini'], index);
  }

  Widget _getComfort(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()].values.elementAt(0), index);
  }

  Widget _getMindful(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()].values.elementAt(1), index);
  }

  Widget _getSides(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()].values.elementAt(2), index);
  }

  String getDay() {
    DateTime now = DateTime.now();
    switch (now.weekday + 1) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      default:
        return "Monday";
    }
  }

  List getWeek() {
    DateTime now = DateTime.now();
    var text = [];
    if (now.day - 7 <= 0) {
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    } else if (now.day - 14 <= 0) {
      text.add("week 2");
      text.add("JypyeLKmIyhEXlLebvHk");
    } else if (now.day - 21 <= 0) {
      text.add("week 3");
      text.add("NvUFdn08oieSPYfLQkU9");
    } else if (now.day - 28 <= 0) {
      text.add("week 4");
      text.add("YToUal6YkEc8XWndizBU");
    } else {
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    }
    return text;
  }

  String getStation() {
    String week = getWeek()[0];
    if (week == "week 1") {
      return "Mediterranean";
    } else if (week == "week 2") {
      return "Pasta";
    } else if (week == "week 3") {
      return "Burrito Bowl";
    } else {
      return "Macaroni and Cheese";
    }
  }
}

class Tile extends StatefulWidget {
  Map<String, dynamic> items;
  BuildContext context;
  int index;


  Tile(this.context, this.items, this.index);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context, items, index);
  }
}

class _Tile extends State<Tile> {
  BuildContext context;
  Map<String, dynamic> items;
  int index;

  _Tile(this.context, this.items, this.index);

  Widget build(context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);

    return Card(
        child: ListTile(
          trailing: SizedBox(width: 130, child: CounterButton(index, items)),
          title: Text(items.keys.elementAt(index)),
          subtitle: Text(format.format(items.values.elementAt(index))),
        ));
  }
}



class NextButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NextButton();
  }

}

class _NextButton extends State<NextButton> {

  @override
  Widget build(BuildContext context) {
    log("in build for nextbuttn");
    log(selected.toString());
    return ValueListenableBuilder<int>(
        valueListenable: _counter,
        builder: (BuildContext context,var s,Widget? child){
          return ElevatedButton(
            onPressed: ifEmpty()? null: ()=> nextPage(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1f5d39)),
            child: const Text("continue"),
          );
        }
    );
    //
  }

  bool ifEmpty(){
    print("in if empty");
    print(selected.toString());
    print(soup1.toString());
    print(soup2.toString());
    if(selected.isEmpty && soup1.isEmpty && soup2.isEmpty){
      return true;
    }
    if(selected.isEmpty && soup1.values.elementAt(0)[0]+soup1.values.elementAt(0)[1]+soup2.values.elementAt(0)[0]+soup2.values.elementAt(0)[1]==0){
      return true;
    }
    return false;
  }

  void nextPage(BuildContext context){
    if(selectedSoups.containsKey(soup1.keys.elementAt(0))){
      selectedSoups.remove(soup1.keys.elementAt(0));
      log(selectedSoups.toString());
    }
    if(selectedSoups.containsKey(soup2.keys.elementAt(0))){
      selectedSoups.remove(soup2.keys.elementAt(0));
      log(selectedSoups.toString());
    }

    if(soup1.values.elementAt(0)[0]!=0||soup1.values.elementAt(0)[1]!=0){
      selectedSoups[soup1.keys.elementAt(0)] = soup1.values.elementAt(0);
    }
    if(soup2.values.elementAt(0)[0]!=0||soup2.values.elementAt(0)[1]!=0){
      selectedSoups[soup2.keys.elementAt(0)] = soup2.values.elementAt(0);
    }


    log(selectedSoups.toString());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Cart()));
  }
}

class CounterButton extends StatefulWidget {
  var index;
  var items;

  CounterButton(this.index, this.items);

  @override
  State<StatefulWidget> createState() {
    return _CounterButton(index, items);
  }
}

class _CounterButton extends State<CounterButton> {
  var index;
  var items;

  _CounterButton(this.index, this.items);

  @override
  Widget build(BuildContext context) {
    var text;
    if (!selected.containsKey(items.keys.elementAt(index))) {
      text = 0;
    } else {
      text = selected[items.keys.elementAt(index)][0];
    }
    var max = 100;
    if(maxLimit.containsKey(items.keys.elementAt(index))){
      max = maxLimit[items.keys.elementAt(index)];
      if(placed.containsKey(items.keys.elementAt(index))){
        max -= placed[items.keys.elementAt(index)] as int;
      }
    }

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
              color: text != 0 ? const Color(0xFFc99a2c) : Colors.grey,
              size: 20,
            ),
            onPressed:
            text != 0 ? () => subtract(items.keys.elementAt(index)) : null,
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
            icon:  Icon(Icons.add_circle,
                color: text < max? Color(0xFFc99a2c): Colors.grey, size: 20),
            onPressed: () {
              if(text<max){
                add(items.keys.elementAt(index), items.values.elementAt(index));
              }
              else{
                null;
              }
            },
          ),
        ],
      ),
    );
  }

  void subtract(String s) {

    setState(() {
      selected[s][0]--;
      if (selected[s][0] == 0) {
        selected.remove(s);
      }
      _counter.value = selected.length + soup1.values.elementAt(0)[0] as int;
      _counter.value += soup1.values.elementAt(0)[1] as int;
      _counter.value += soup2.values.elementAt(0)[0] as int;
      _counter.value += soup2.values.elementAt(0)[1] as int;
      log(selected.toString());

    });
  }

  void add(String s, var i) {


    setState(() {
      if (selected[s] != null) {
        selected[s][0]++;
      } else {
        selected[s] = [1, i];
      }
      _counter.value = selected.length + soup1.values.elementAt(0)[0] as int;
      _counter.value += soup1.values.elementAt(0)[1] as int;
      _counter.value += soup2.values.elementAt(0)[0] as int;
      _counter.value += soup2.values.elementAt(0)[1] as int;
      log(selected.toString());
    });
  }
}

class SoupTrailer extends StatefulWidget{
  var index;
  var items;
  SoupTrailer(this.index, this.items);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SoupTrailer(index,items);
  }

}

class _SoupTrailer extends State<SoupTrailer> {

  var index;
  var items;
  var dropdownValue1;
  bool checkSoup(){
    //returns true if the current soup is the first soup
    if(index==0){
      return true;
    }
    return false;
  }
  @override
  void initState(){
    if(!initDone){

      soup1 = {weeklyItems['Soup'].keys.elementAt(0):[0,0]};


      soup2 = {weeklyItems['Soup'].keys.elementAt(1):[0,0]};
      initDone = true;
    }



  }

  _SoupTrailer(this.index, this.items);

  @override
  Widget build(BuildContext context) {
    List large = [];
    List small = [];
    var l = 100;
    var s = 100;

    if(maxLimit.containsKey(items.keys.elementAt(index))){
      var soup = maxLimit[items.keys.elementAt(index)];
      if(soup.containsKey("large")){
        l = soup['large'];
      }
      if(placed.containsKey(items.keys.elementAt(index))){
        soup = placed[items.keys.elementAt(index)];
        if(soup.containsKey("large")){
          l -= soup['large'] as int;
        }
      }
      soup = maxLimit[items.keys.elementAt(index)];
      if(soup.containsKey("small")){
        s = soup['small'];
      }
      if(placed.containsKey(items.keys.elementAt(index))){
        soup = placed[items.keys.elementAt(index)];
        if(soup.containsKey("small")){
          s -= soup['small'] as int;
        }
      }
    }

    for(int i = 0; i<=l;i++){
      large.add("$i");
    }
    for(int i = 0; i<=s;i++){
      small.add("$i");
    }

    return Container(
      width: 250,
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
                value: checkSoup() ? soup1.values.elementAt(0)[0].toString():soup2.values.elementAt(0)[0].toString(),
                dropdownMaxHeight: 250,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    if (checkSoup()){
                      soup1[soup1.keys.elementAt(0)][0] = int.parse(value!);

                    }
                    else{
                      soup2[soup2.keys.elementAt(0)][0] = int.parse(value!);
                    }
                    _counter.value = selected.length + soup1.values.elementAt(0)[0] as int;
                    _counter.value += soup1.values.elementAt(0)[1] as int;
                    _counter.value += soup2.values.elementAt(0)[0] as int;
                    _counter.value += soup2.values.elementAt(0)[1] as int;
                    log("soup 1: ${soup1.toString()}");
                    log("soup 2: ${soup2.toString()}");
                  });
                },
                items: large.map<DropdownMenuItem<String>>((var value) {
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
                value: checkSoup() ? soup1.values.elementAt(0)[1].toString():soup2.values.elementAt(0)[1].toString(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    if (checkSoup()){
                      soup1[soup1.keys.first][1] = int.parse(value!);
                    }
                    else{
                      soup2[soup2.keys.first][1] = int.parse(value!);
                    }
                    _counter.value = selected.length + soup1.values.elementAt(0)[0] as int;
                    _counter.value += soup1.values.elementAt(0)[1] as int;
                    _counter.value += soup2.values.elementAt(0)[0] as int;
                    _counter.value += soup2.values.elementAt(0)[1] as int;
                    log("soup 1: ${soup1.toString()}");
                    log("soup 2: ${soup2.toString()}");
                  });
                },
                items: small.map<DropdownMenuItem<String>>((var value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
          ),


        ],
      ),
    );
  }
}