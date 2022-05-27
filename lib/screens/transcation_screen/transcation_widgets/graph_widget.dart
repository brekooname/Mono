import 'package:flutter/material.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/transcation_screen/transcation_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({
    Key? key,
    required TooltipBehavior tooltipBehavior,
    required List<TranscationModel> chartData,
  }) : _tooltipBehavior = tooltipBehavior, _chartData = chartData, super(key: key);

  final TooltipBehavior _tooltipBehavior;
  final List<TranscationModel> _chartData;

  @override
  Widget build(BuildContext context) {
     return
    SfCircularChart(
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<TranscationModel, String>(
            dataSource: _chartData,
            xValueMapper: (TranscationModel data, _) => data.category,
            yValueMapper: (TranscationModel data, _) => data.amount,
            dataLabelSettings:
                const DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
    );
  
  }
}
 List<TranscationModel> getChart() {
       final List <TranscationModel> data ;
    
    var distint= TranscationDB.instance.incomelistnotifier.value;
    print(distint);

    final List<TranscationModel> chartData =distint;
     
    
     
    return chartData;
  }

class Data {
 
  final String categories;
  final double amount;
   Data(this.categories, this.amount);
}