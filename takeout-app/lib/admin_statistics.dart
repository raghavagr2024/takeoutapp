import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'Item.dart';

List names = [];
var selectedDate = "2023-06-29";

class StatsPage extends StatelessWidget {
  Map stats = {};

  @override
  Widget build(BuildContext context) {
    print("getting data");

    return FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print(stats);
            List items = [];
            for (int i = 0; i < stats.length; i++) {
              Map day = stats.values.elementAt(i);
              for (int j = 0; j < day.length; j++) {
                if (day.values.elementAt(j) is Map) {
                  Map sizes = day.values.elementAt(j);
                  print(sizes);
                  for (int k = 0; k < sizes.length; k++) {
                    items.add(Data_Point(
                      name:
                          "${sizes.keys.elementAt(k)} ${day.keys.elementAt(j)}",
                      date: stats.keys.elementAt(i),
                      amount: sizes.values.elementAt(k),
                    ));
                  }
                } else {
                  items.add(Data_Point(
                    name: day.keys.elementAt(j),
                    date: stats.keys.elementAt(i),
                    amount: day.values.elementAt(j),
                  ));
                }
              }
            }
            List<BarChartGroupData> points = [];

            int index = 0;
            for (Data_Point data in items) {
              if (data.date == selectedDate) {
                points.add(BarChartGroupData(
                    x: index,
                    barRods: [BarChartRodData(toY: data.amount.toDouble())]));
                names.add(data.name + "                                   ");
                index++;
              }
            }
            print(points);
            print(names);
            return Column(
              children: [
                SizedBox(height: 200,),
                SizedBox(
                  height: 500,
                  child: BarChart(BarChartData(
                      groupsSpace: 50,
                      barTouchData: BarTouchData(enabled: true,),
                      barGroups: points,
                      titlesData: FlTitlesData(


                          bottomTitles: AxisTitles(

                              sideTitles: SideTitles(
                                  showTitles: true,

                                  getTitlesWidget: getBottomTitles,
                                reservedSize: 42,
                              )),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: false,
                          )),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          )))),
                )
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      names[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
      angle: pi*-1/2.5,
    );
  }

  Future<bool> getData() async {
    print("in get data");
    await FirebaseFirestore.instance
        .collection('statistics')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        stats[doc.id] = doc.data();
      }
    });

    if (stats.isEmpty) {
      return false;
    }
    return true;
  }
}
