import 'package:flutter/material.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/transcation_screen/transcation_screen.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({
    Key? key,
    required TooltipBehavior tooltipBehavior,
    //required List<TranscationModel> chartData,
  }) : _tooltipBehavior = tooltipBehavior,  super(key: key);

  final TooltipBehavior _tooltipBehavior;
 // final List<TranscationModel> _chartData;

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Chartdata> expenseData=getChart(
      TranscationDB.instance.expenselistnotifier.value);
      final List<Chartdata> incomeData=getChart(
      TranscationDB.instance.incomelistnotifier.value);
        final List<Chartdata> allData=getChart(
      TranscationDB.instance.transcationNotifier.value);
      
     return
    SfCircularChart(
      legend: Legend(isVisible: true),
      tooltipBehavior: widget._tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<Chartdata, String>(
            dataSource: itemvalue=='All'?allData:itemvalue=='Income'?incomeData:expenseData,
            xValueMapper: (Chartdata data, _) => data.categories,
            yValueMapper: (Chartdata data, _) => data.amount,
            dataLabelSettings:
                const DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
    );
  
  }
}


  List<Chartdata> getChart(List<TranscationModel> model) {
    double value;
    String catagoryname;
    List visted = [];
    List<Chartdata> thedata = [];

    for (var i = 0; i < model.length; i++) {
      visted.add(0);
    }

    for (var i = 0; i < model.length; i++) {
      value = model[i].amount;
      catagoryname = model[i].category;

      for (var j = i + 1; j < model.length; j++) {
        if (model[i].category == model[j].category) {
          value += model[j].amount;
          visted[j] = -1;
        }
      }

      if (visted[i] != -1) {
       
          thedata.add(Chartdata(categories: catagoryname, amount: value));
        
      }
    
    }
    return thedata;
  }

class Chartdata {
  String? categories;
  double? amount;
  Chartdata({required this.categories, required this.amount});
}