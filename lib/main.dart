import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/services/db/db.dart';

import 'package:wallpaper_app/view/get_stated_view/get_stated_view.dart';

var database = DatabaseHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database.initDatabase();
  DatabaseHelper().getAll();

  runApp(const MyApp());
}

@override
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'RobotoMono'),
        debugShowCheckedModeBanner: false,
        home: const GetStartedScreen(),
      ),
    );
  }
}
