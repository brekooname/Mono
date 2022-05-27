import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/screens/edit_screen/edit_screen.dart';
import 'package:mono/screens/widgets/add_clipper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/transcation_model/transcation_model.dart';
import 'transcation_widgets/graph_widget.dart';
import 'transcation_widgets/heading_widget.dart';


double totalBalance = 0;
double totalIncome = 0;
double totalExpense = 0;

class TranscationScreen extends StatefulWidget {
  const TranscationScreen({Key? key}) : super(key: key);

  @override
  State<TranscationScreen> createState() => _TranscationScreenState();
}

totalBalanceCheck(List<TranscationModel> data) {
  totalBalance = 0;
  totalIncome = 0;
  totalExpense = 0;

  for (var value in data) {
    if (value.type == "Income") {
      totalIncome = totalIncome + value.amount;
    } else if (value.type == 'Expense') {
      totalExpense = totalExpense + value.amount;
    }
    totalBalance = totalIncome - totalExpense;
  }


}

class _TranscationScreenState extends State<TranscationScreen> {
  late List<TranscationModel> _chartData;
  late TooltipBehavior _tooltipBehavior;
   bool visible=false;
  @override
  void initState() {

    TranscationDB.instance.refresh();
   
    _chartData = getChart();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  var item = ['All', 'Income', 'Expense', 'Today', 'Yesterday', 'Custom'];
  String itemvalue = 'All';

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blueGrey),
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
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newvalue) {
                            
                              itemvalue = newvalue!;
                          

                            setState(() {});
                          }),
                    ),

                    ElevatedButton(onPressed: (){
                   
                    }, child:const Text('data')),
                 
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: GraphWidget(
                    tooltipBehavior: _tooltipBehavior, chartData: _chartData),
              ),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: HexColor('#E1DFD9'),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: headinginnermethod()),
              Container(
                color: HexColor('#E1DFD9'),
                height: 634.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: ValueListenableBuilder(
                    valueListenable: listingmethod(),
                    builder: (BuildContext context,
                        List<TranscationModel> newlist, _) {
                      
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          TranscationModel _value = newlist[index];
                         // totalBalanceCheck(newlist);
                          return Slidable(
                            key: const ValueKey(1),
                            startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                      backgroundColor: HexColor('#E1DFD9'),
                                      foregroundColor: Colors.blue,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                      onPressed: ((context) async {
                                        final newvalue = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditScreen(
                                                      value:_value
                                                        // amount: _value.amount,
                                                        // category:_value.category,
                                                        // date: _value.date,
                                                        // type: _value.type,
                                                        // id: _value.id
                                                        )));
                                       setState(() {
                                         _value=newvalue;
                                       });                 
                                      })
                                      
                                      ),
                                ]),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                      backgroundColor: HexColor('#E1DFD9'),
                                      foregroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      onPressed: ((context) {
                                        TranscationDB.instance
                                            .deletetranscation(_value.id);
                                        TranscationDB.instance.refresh();
                                        // ignore: prefer_const_constructors
                                        final snack = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: const Text("Deleted"));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack);
                                      })),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 33,
                                    child: Text(
                                      parsedate(_value.date),
                                    ),
                                  ),
                                  title: Text(_value.category,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  subtitle: Text("${_value.purpose}"),
                                  trailing: _value.type == 'Expense'
                                      ? Text(
                                          "- ₹${_value.amount}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "+ ₹${_value.amount}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
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
      ),
    );
  }

  headinginnermethod() {
    if (itemvalue == "Income") {
      return HeadingMethod(
          headtext: 'My savings', amount: totalIncome.toString());
    } else if (itemvalue == 'Expense') {
      return HeadingMethod(
          headtext: ' My spendings', amount: totalExpense.toString());
    } else {
      return HeadingMethod(
          headtext: 'All Transcation', amount: totalBalance.toString());
    }
  }

  listingmethod() {
    if (itemvalue == "Income") {
      return TranscationDB.instance.incomelistnotifier;
    } else if (itemvalue == "Expense") {
      return TranscationDB.instance.expenselistnotifier;
    } else if (itemvalue == "Today") {
      return TranscationDB.instance.todaylistnotifier;
    } else if (itemvalue == "Yesterday") {
      return TranscationDB.instance.yesterdaylistnotifier;
   /// } else if(itemvalue=="Custom") {
      
    }else{
      return TranscationDB.instance.transcationNotifier;
    }
  }

  String parsedate(DateTime date) {
    final _date = DateFormat().add_MMMd().format(date);
    final _splitdate = _date.split(" ");
    return '${_splitdate.last}\n${_splitdate.first}';
  }

  



}
