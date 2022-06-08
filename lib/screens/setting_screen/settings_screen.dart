import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/providers/theme_provider.dart';
import 'package:mono/screens/IntroPages/splash_screen.dart';
import 'package:mono/screens/add_screen/add_screen.dart';
import 'package:mono/screens/setting_screen/settings_widgets/about_screen.dart';
import 'package:mono/screens/setting_screen/settings_widgets/notification.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

bool switchnoti = true;
//bool _switchtheme = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool expandabout = false;
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.listen(onClickNotifications);
  }

  onClickNotifications(String? payload) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final themepovider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
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
                          color: Theme.of(context).dividerColor,
                          height: 17.0.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w, top: 3.h),
                        child: Container(
                          width: 90.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Theme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SwitchListTile(
                                    title: Text(
                                      "Notification",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    secondary: const Icon(Icons.notifications),
                                    activeColor: mainHexcolor,
                                    value: switchnoti,
                                    onChanged: (newvalue) {
                                      setState(() {
                                        switchnoti = newvalue;
                                      });
                                      switchnoti == true
                                          ? NotificationApi.shownotification(
                                              title: 'Mono',
                                              body:
                                                  "Don't Forget To Add Your Transaction",
                                              scheduleDate:
                                                  const Time(18, 00, 00))
                                          : const SizedBox();
                                    }),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SwitchListTile(
                                  activeColor: mainHexcolor,
                                  title: Text(
                                    "Dark Mode",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  secondary: Icon(themepovider.darkTheme
                                      ? Icons.dark_mode_outlined
                                      : Icons.light_mode_outlined),
                                  onChanged: (newvalue) {
                                    setState(() {
                                      themepovider.darkTheme = newvalue;
                                    });
                                  },
                                  value: themepovider.darkTheme,
                                ),
                                const Divider(),
                                Text(
                                  "More",
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColorDark),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(1.w, 5.5.h))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AboutScreen()));
                                    },
                                    child: const Text("About",
                                        style: TextStyle())),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColorDark),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(1.w, 5.5.h))),
                                    onPressed: () async {
                                      // ignore: deprecated_member_use
                                      if (!await launch(
                                          'mailto:rafikkvavoor@gmail.com?subject=Mono-App&body=write your own...')) {
                                        throw 'Could not send massage';
                                      }
                                    },
                                    child: const Text("Send feedback")),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColorDark),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(1.w, 5.5.h))),
                                    onPressed: () async {
                                      TranscationDB.instance.cleardatabase();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SplashScreen()),
                                          (route) => false);
                                    },
                                    child: const Text("Reset App"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5.h,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
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
    var firstend = Offset(size.width / 1.65, size.height - 35.0);
    path.quadraticBezierTo(
        firststart.dx, firststart.dy, firstend.dx, firstend.dy);
    //path.lineTo(size.width/2.25, size.height);
    var secondstart =
        Offset(size.width - (size.width / 6.29), size.height - 50.0);
    var secondend = Offset(size.width, size.height - 4);
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
