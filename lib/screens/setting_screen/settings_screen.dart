import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mono/constants/app_color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _switchnoti = false;
  bool _switchtheme = false;
  bool expandabout = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
               height: MediaQuery.of(context).size.height*.88,
              child: Stack(
               clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: mainHexcolor,
                          height: 134.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 30),
                        child: Container(
                          width: 360,
                          height: 520,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Push Notifications",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    CupertinoSwitch(
                                      activeColor: mainHexcolor,
                                      onChanged: ( value) {
                                        setState(() {
                                          _switchnoti = value;
                                        });
                                      },
                                      value: _switchnoti,
                                    )
                                  ],
                                ),
                             
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Dark Mode",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    CupertinoSwitch(
                                      activeColor: mainHexcolor,
                                        value: _switchtheme,
                                        onChanged: ( newvalue) {
                                        
                                          setState(() {
                                            _switchtheme = newvalue;
                                          });
                                        })
                                  ],
                                ),
                                const Divider(),
                                Text(
                                  "More",
                                  style: TextStyle(
                                      color: Colors.grey.shade400, fontSize: 18),
                                ),
                               const ExpansionTile(
                                  title:  Text("About Us"),
                                  // onExpansionChanged:(){} ,
                                  children:  [Text("data")],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 60,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  
                  Positioned(
                      left: 0,
                      bottom: -20,
                      child: Image.asset(
                        'assets/images/singhboy.png',
                        width: 280,
                      )),
                ],
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firststart = Offset(size.width / 6.29, size.height);
    var firstend = Offset(size.width / 1.65, size.height - 40.0);
    path.quadraticBezierTo(
        firststart.dx, firststart.dy, firstend.dx, firstend.dy);
    //path.lineTo(size.width/2.25, size.height);
    var secondstart = Offset(size.width - (size.width / 6), size.height - 50.0);
    var secondend = Offset(size.width, size.height - 5);
    path.quadraticBezierTo(
        secondstart.dx, secondstart.dy, secondend.dx, secondend.dy);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
