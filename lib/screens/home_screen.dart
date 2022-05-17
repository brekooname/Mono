import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/screens/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? enteredname;
  

  @override
  void initState(){
        getnamedata();

    super.initState();
  }

   getnamedata()async{
    final sharedprefer = await SharedPreferences.getInstance();
      enteredname =sharedprefer.getString('namekey');
     setState(() {
       
     });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70.0),
                          bottomRight: Radius.circular(35.0)),
                      color: mainHexcolor,
                    ),
                    height: 470,
                  ),
                ),
                  Positioned(
                  top: 50,
                  left: 40,
                  child: Text(
                  "Hi, $enteredname ",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                const Positioned(
                  top: 95,
                  left: 40,
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 40,
                  child: Stack(
                    children: [
                      Container(
                        height: 160,
                        width: 310,
                        decoration: BoxDecoration(
                            color: HexColor("#37474F"),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Available balance",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Text(
                                "₹800",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 33,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "See details",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                          bottom: -80,
                          right: -40,
                          child: Image(
                            image: AssetImage("assets/images/piggybank.png"),
                            width: 180,
                            height: 180,
                          )),
                    ],
                    clipBehavior: Clip.none,
                  ),
                ),
                const Positioned(
                  left: -43.0,
                  bottom: -164,
                  child: Image(
                    image: AssetImage("assets/images/monotree.png"),
                    width: 300,
                    height: 300,
                  ),
                ),
              ],
              clipBehavior: Clip.none,
            ),
            Column(
              children: [
                const Text(
                  "Cash",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
               const SizedBox(height: 20,),
                Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: HexColor('#42887C'),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.house_siding,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "₹1000.0",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Income",
                              ),
                            ],
                          ),
                        ),
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor('#D9E7E5'),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 230, 146, 21),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "₹1001.0",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Expense",
                              ),
                            ],
                          ),
                        ),
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor('#E6E2E6'),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40,
                    left: 158,
                    child: SizedBox(
                      width: 80,
                      height: 70.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddScreen();
                          }));
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 35,
                        ),
                        backgroundColor: HexColor('#FFC727'),
                      ),
                    ),
                  )
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 1.17);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

