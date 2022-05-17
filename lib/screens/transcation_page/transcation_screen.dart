import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:mono/screens/widgets/add_clipper.dart';

import '../../models/transcation_model/transcation_model.dart';

class TranscationScreen extends StatefulWidget {
  const TranscationScreen({Key? key}) : super(key: key);

  @override
  State<TranscationScreen> createState() => _TranscationScreenState();
}

class _TranscationScreenState extends State<TranscationScreen> {
  late List<Data> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TranscationDB.instance.refresh();
    _chartData = getChart();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  var item = ['All', 'Income', 'Expense'];
  String itemvalue = 'All';
  @override
  Widget build(BuildContext context) {
    TranscationDB.instance.refresh();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                child: const Center(
                  child: Text(
                    " All Transctions",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                color: mainHexcolor,
                height: 110.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: mainHexcolor),
                        borderRadius: BorderRadius.circular(10)),
                    width: 130.0,
                    height: 34.0,
                    child: DropdownButtonFormField(
                        iconSize: 34,
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        value: itemvalue,
                        items: item.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            itemvalue = newvalue!;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Positioned(
                  // bottom: 19,
                  child: SfCircularChart(
                    // borderWidth: 35.0,
                    // margin:const EdgeInsets.only(left:10.0, bottom: 20.0),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      DoughnutSeries<Data, String>(
                          dataSource: _chartData,
                          xValueMapper: (Data data, _) => data.categories,
                          yValueMapper: (Data data, _) => data.amount,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                  ),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "All Transcations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  "20000",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            ),
            Container(
              color: HexColor('#F4F6F6'),
              height: 262.5,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: ValueListenableBuilder(
                  valueListenable: TranscationDB.instance.transcationNotifier,
                  builder: (BuildContext context,
                      List<TranscationModel> newlist, _) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final _value = newlist[index];
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                    onPressed: ((context) {})),
                              ]),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    onPressed: ((contex) {
                                     

                                      TranscationDB.instance
                                          .deletetranscation(_value.id!);
                                      TranscationDB.instance.refresh();
                                    })),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Card(
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: _value.type == "Income"
                                    ? const Icon(
                                        Icons.arrow_circle_up_rounded,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.arrow_circle_down_rounded,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                title: Text(_value.type),
                                subtitle:
                                    Text("${_value.category}  ${_value.purpose}"),
                                trailing: Text("RS ${_value.amount}"),
                              ),
                            ),
                          ),
                        );
                      },
                   
                      itemCount: newlist.length,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  List<Data> getChart() {
    final List<Data> chartData = [
      Data('Shopping', 100),
      Data('Travel', 200),
      Data('Food', 100),
      Data('Medical', 100),
      Data('Other', 1000)
    ];
    return chartData;
  }
}

class Data {
  Data(this.categories, this.amount);
  final String categories;
  final int amount;
}
