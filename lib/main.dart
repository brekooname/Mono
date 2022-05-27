import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mono/constants/app_color.dart';
import 'package:mono/database/Transctions_DB/transcations_db.dart';
import 'package:mono/models/category_model/category_model.dart';
import 'package:mono/models/transcation_model/transcation_model.dart';
import 'package:mono/screens/IntroPages/splash_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TranscationModelAdapter().typeId)){
    Hive.registerAdapter(TranscationModelAdapter());
  }
  await TranscationDB.instance.refresh();
  await TranscationDB.instance.getalltranscation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return        MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: mainHexcolor),
        home:const SplashScreen(),
     );
  }
}
