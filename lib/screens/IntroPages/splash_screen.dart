import 'package:flutter/material.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/screens/IntroPages/onbording_screen.dart';
import 'package:mono/screens/widgets/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: mainHexcolor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Appicon.png'),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "MONO",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Future _navigator() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnboardScreen()));
  }

  checkdata() async {
    final sharedprefer = await SharedPreferences.getInstance();
    final nameisther = sharedprefer.getString('namekey');
    await Future.delayed(const Duration(milliseconds: 5000));

    nameisther == null
        ? _navigator()
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavigator()));
  }
}
