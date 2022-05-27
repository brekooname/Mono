import 'package:flutter/material.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/add_screen/decoration_functions.dart';
import 'package:mono/screens/widgets/add_clipper.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class EditScreen extends StatefulWidget {
  // final double amount;
  // final DateTime date;
  // final String category;
  // final String type;
  // final String id;
  final TranscationModel value;

  //final String? purpose;

  const EditScreen(
      {Key? key,
      // required this.amount,
      // required this.category,
      // required this.date,
      // required this.type,
      // required this.id,
      // this.purpose
      required this.value,
      })
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<dynamic> transcationType = [];
  List<dynamic> categorieslist = [];
  List<dynamic> categories = [];

  String? transctiontypeid;
  String? categoryid;

  DateTime selectedDate = DateTime.now();

  final _amountcontrol = TextEditingController();
  final _notescontrol = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _amountcontrol.text = widget.value.amount.toString();
    selectedDate = widget.value.date;
    // _notescontrol.text=widget.purpose.toString();

    super.initState();

    transcationType.add({"id": "Income", 'name': 'Income'});
    transcationType.add({"id": 'Expense', "name": 'Expense'});

    categorieslist = [
      {'Id': 'Shopping', 'Name': 'Shopping', 'parentId': 'Expense'},
      {'Id': 'Travel', 'Name': 'Travel', 'parentId': 'Expense'},
      {'Id': 'Food', 'Name': 'Food', 'parentId': 'Expense'},
      {'Id': 'Rent', 'Name': 'Rent', 'parentId': 'Expense'},
      {'Id': 'Medical', 'Name': 'Medical', 'parentId': 'Expense'},
      {'Id': 'Utilities', 'Name': 'Utilites', 'parentId': 'Expense'},
      {'Id': 'Educations`', 'Name': 'Educations', 'parentId': 'Expense'},
      {'Id': 'Salary', 'Name': 'Salary', 'parentId': 'Income'},
      {'Id': 'Freelance', 'Name': 'Freelance', 'parentId': 'Income'},
      {'Id': 'Commission', 'Name': 'Commission', 'parentId': 'Income'},
    ];
    //transctiontypeid = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: mainHexcolor,
                    height: 300,
                  ),
                ),
                const Positioned(
                  top: 55,
                  left: 130,
                  child: Text(
                    "Edit Transcation",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Positioned(
                  top: 95,
                  left: 23.0,
                  child: Container(
                    width: 350.0,
                    height: 710,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(1), blurRadius: 10)
                        ]),
                    child: Form(
                      key: _formkey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textstyle("transcation type"),
                            const SizedBox(
                              height: 10,
                            ),
                            FormHelper.dropDownWidget(
                              context,
                              widget.value.type,
                              transctiontypeid,
                              transcationType,
                              (onchangeval) {
                                categoryid = null;
                                setState(() {});
                                transctiontypeid = onchangeval;

                                //print("after ${widget.type}");
                                setState(() {
                                  categories = categorieslist
                                      .where((categoryItem) =>
                                          categoryItem["parentId"].toString() ==
                                          onchangeval.toString())
                                      .toList();
                                });
                              },
                              (onValidate) {
                                if (onValidate == null) {
                                  return;
                                }
                              },
                              borderColor: Colors.grey,
                              borderRadius: 10,
                              borderFocusColor: mainHexcolor,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            textstyle('Amount'),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return;
                                }
                                return null;
                              },
                              controller: _amountcontrol,
                              keyboardType: TextInputType.number,
                              decoration: textfielddecor("Enter Amount"),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            textstyle("Date"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final date = await pickDate(context);
                                if (date == null) return;
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.only(right: 170.0),
                                child: Text(
                                  '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 87, 83, 83)),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                side: const BorderSide(color: Colors.grey),
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                minimumSize: const Size(400, 55),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            textstyle("Categories"),
                            const SizedBox(
                              height: 10,
                            ),
                            FormHelper.dropDownWidget(
                              context,
                              widget.value.category,
                              categoryid,
                              categories,
                              (onchangeval) {
                                setState(() {});
                                categoryid = onchangeval;
                              },
                              (onValidate) {
                                return null;
                              },
                              borderColor: Colors.grey,
                              borderRadius: 10,
                              borderFocusColor: mainHexcolor,
                              optionValue: "Id",
                              optionLabel: "Name",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            textstyle("Notes"),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _notescontrol,
                              keyboardType: TextInputType.text,
                              decoration: textfielddecor('Enter Notes'),
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updatetranscation();
                                
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 246, 243, 243)),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: mainHexcolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                minimumSize: const Size(400, 55),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
              clipBehavior: Clip.none,
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate(context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return null;
  }

  Future updatetranscation() async {
    final amountval = _amountcontrol.text;
    final purposeval = _notescontrol.text;

    final _parseamount = double.tryParse(amountval);
    if (_parseamount == null) {
      return;
    }
    if (categoryid == null) {
      return;
    }
        final _model = TranscationModel(
        type: transctiontypeid!,
        amount: _parseamount,
        date: selectedDate,
        category: categoryid!,
        purpose: purposeval,
        id: widget.value.id);

    TranscationDB.instance.updatetranscation(_model);
    print('after value $_parseamount');
       Navigator.of(context).pop( _model);
       
  }
}
