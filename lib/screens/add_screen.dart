

import 'package:flutter/material.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/transcation_page/transcation_screen.dart';
import 'package:mono/screens/widgets/add_clipper.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../database/categories_DB/category_db.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<dynamic> transcationType = [];
  List<dynamic> categorieslist = [];
  List<dynamic> categories = [];
 // ValueNotifier<int> selecteddropdownindexnotifier = ValueNotifier(1);

  String? transctiontypeid;
  String? categoryid;
  // var categories = [
  //   'Shopping',
  //   'Travel',
  //   'Food',
  //   'Rent',
  //   'Medical',
  //   'Utilites',
  //   'Educations',
  //   'Other'
  // ];
  //late String categovalue;

  DateTime selectedDate = DateTime.now();

  final _amountcontrol = TextEditingController();
  final _notescontrol = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    CategoryDB().refreshUI();

    // categovalue = categories[0];
    transcationType.add({"id": "Income",'name': 'Income'});
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                    "Add Transcation",
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
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textstyle("transcation type"),
                            const SizedBox(
                              height: 10,
                            ),
                            
                                   FormHelper.dropDownWidget(
                                    context,
                                    "Select Transcation Type",
                                    transctiontypeid,
                                    transcationType,
                                    (onchangeval) {
                                         categoryid = null;
                                      setState(() {});
                                      transctiontypeid = onchangeval;
                                      print('trans$onchangeval');
                                      categories = categorieslist
                                          .where((categoryItem) =>
                                              categoryItem["parentId"]
                                                  .toString() ==
                                              onchangeval.toString())
                                          .toList();
                                     
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
                                "Select categories",
                                categoryid,
                                categories, (onchangeval) {
                                  setState(() {
                                    
                                  });
                              categoryid = onchangeval;
                              print(" catergo :$onchangeval");
                            }, (onValidate) {
                               
                                return null;
                              
                            },
                                borderColor: Colors.grey,
                                borderRadius: 10,
                                borderFocusColor: mainHexcolor,
                                optionValue: "Id",
                                optionLabel: "Name",
                                
                                ),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButtonFormField(
                            //     alignment: AlignmentDirectional.topStart,
                            //     decoration: dropdowndecor(),
                            //     value: categovalue,
                            //     items: categories.map((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //     onChanged: (String? value) {
                            //       setState(() {
                            //         categovalue = value!;
                            //       });
                            //     },
                            //   ),
                            // ),

                            // AddTodoButton(
                            //     selectedindex:
                            //         selecteddropdownindexnotifier.value),

                            //                    ElevatedButton(onPressed: (){
                            //                         Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                            //   return const _AddTodoPopupCard();
                            // }));
                            //                    }, child:const Text("add categories")),///////////////////////////////////////
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
                             //   print('Dropdown index:${selecteddropdownindexnotifier.value}');
                                
                                

                                if (_formkey.currentState!.validate()) {
                                  addtransbutton();
                  
                                }
                              },
                              child: const Text(
                                'Add',
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

  Text textstyle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 116, 112, 112)),
    );
  }

  InputDecoration textfielddecor(String text) {
    return InputDecoration(
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mainHexcolor)),
        hintText: text,
        border: const OutlineInputBorder());
  }

  InputDecoration dropdowndecor() {
    return InputDecoration(
        //  isCollapsed: true,
        isDense: false,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainHexcolor, width: 1.0),
            borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4)));
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

  Future addtransbutton() async {
    final amountval = _amountcontrol.text;
    final purposeval = _notescontrol.text;
   
    final _parseamount = double.tryParse(amountval);
    if (_parseamount == null) {
      return;
    }
    if (categoryid == null) {
      return;
    }


  final _model=  TranscationModel(
            
        type: transctiontypeid!,
        amount: _parseamount,
        date: selectedDate,
        category: categoryid!,
        purpose: purposeval);
        TranscationDB.instance.addtranscation(_model);
        print(_model.amount);
        print(_model.category);
        print(_model.date);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TranscationScreen()));
  }
  
}
