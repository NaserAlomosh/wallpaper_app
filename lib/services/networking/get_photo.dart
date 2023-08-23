import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photo_model/photo_model.dart';

class ApiPhoto {
  Future<List<Photos>> fetchPhotos() async {
    http.Response response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=nature&ocean'),
        headers: {
          'Authorization':
              'btXTcxKWEyHxxBJXGT7XvvPTrj71CvaPwxNc5djScSPFYyQfBOT1b6FR'
        });
    if (response.statusCode == 200) {
      String data = response.body;
      var jsonData = jsonDecode(data);
      PhotoModel photoModel = PhotoModel.fromJson(jsonData);

      List<Photos> photoList =
          photoModel.photos!.map((e) => Photos.fromJson(e)).toList();

      return photoList;
    } else {
      log(response.statusCode);
      return [];
    }
  }
}
