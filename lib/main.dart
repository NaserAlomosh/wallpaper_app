import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/model/photo_model/photo_model.dart';
import 'package:wallpaper_app/services/db/db.dart';
import 'package:wallpaper_app/services/networking/get_photo.dart';

import 'package:wallpaper_app/view/get_stated_view/get_stated_view.dart';

var database = DatabaseHelper();
List<Photos> photos = [];
bool isFavorite = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database.initDatabase();
  photos = await ApiPhoto().fetchPhotos();
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
        checkerboardOffscreenLayers: false,
        theme: ThemeData(fontFamily: 'RobotoMono'),
        debugShowCheckedModeBanner: false,
        home: const GetStartedScreen(),
      ),
    );
  }
}
