import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mono/screens/widgets/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formkey=GlobalKey<FormState>();

class OnboardScreen extends StatelessWidget {
   OnboardScreen({Key? key}) : super(key: key);

final _namecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: HexColor('#EEF8F7'),
                      height: 450.0,
                    ),
                  ),
                  Positioned(
                      bottom: -20,
                      right: 30,
                      child: Image.asset(
                        'assets/images/boardboy.png',
                        width: 330,
                      )),
                  Positioned(
                    top: 106,
                    left: 76,
                    child: Image.asset("assets/images/Coint.png"),
                    height: 75,
                  ),
                  Positioned(
                    top: 150,
                    right: 80,
                    child: Image.asset("assets/images/Donut.png"),
                    height: 65,
                  ),
                ],
                clipBehavior: Clip.none,
              ),
            ),
            Column(children: [
              const SizedBox(
                height: 30,
              ),
              headingtext("Spend Smarter"),
              headingtext("Save More"),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, right: 30),
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: _namecontroller,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                      return 'please enter your name';
                      }else{
                        return null;
                      }
                      
                
                    }),
                    
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#429690')),
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: HexColor('#FBF3F3'),
                        hintText: 'Please Enter Your name',
                        hintStyle: const TextStyle(fontSize: 12.5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor("#438883")),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor('#3E7C78')),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    minimumSize:
                        MaterialStateProperty.all(const Size(350, 60))),
              onPressed: () {
               // print(namecontrol);
                if(_formkey.currentState!.validate()){
                   gotohome(context);
                }
 
               
              }

                ,
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Text headingtext(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: HexColor("#438883")),
    );
  }

  gotohome(context)async{
    final  namecontrol=_namecontroller.text;
    final sharedprefer = await SharedPreferences.getInstance();
     sharedprefer.setString('namekey',namecontrol);
    
    
 
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomNavigator()), (route) => false);
    
    }

   
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 1.2);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
