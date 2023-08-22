// // ignore_for_file: avoid_print

// import 'dart:convert';

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photo_model/photo_model.dart';

// import '../../photos_model.dart/photo_model/photo_model.dart';
// import '../../photos_model.dart/photo_model/photos.dart';

class ApiPhoto {
  // ignore: non_constant_identifier_names
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



















// class ApiPhoto {
//   Future getData() async {
//     try {
//       http.Response response = await http.get(
//           Uri.parse('https://api.pexels.com/v1/search?query=nature'),
//           headers: {
//             'Authorization':
//                 'btXTcxKWEyHxxBJXGT7XvvPTrj71CvaPwxNc5djScSPFYyQfBOT1b6FR'
//           });
//       if (response.statusCode == 200) {
//         String data = response.body;
//         var jsonData = jsonDecode(data);

//         List<PhotoModel> photoModel;
//         PhotoModel.fromJson(jsonData);
//       } else {
//         print('status code = ${response.statusCode}');
//       }
//     } catch (ex) {
//       print(ex);
//     }
//   }

  // Future<List<Photo>> fetchArticlesByCategory(String category) async {
  //   try {
  // http.Response response = await http.get(
  //         Uri.parse('https://api.pexels.com/v1/search?query=$ca'),
  //         headers: {
  //           'Authorization':
  //               'btXTcxKWEyHxxBJXGT7XvvPTrj71CvaPwxNc5djScSPFYyQfBOT1b6FR'
  //         });
  //     if (response.statusCode == 200) {
  //       String data = response.body;
  //       var jsonData = jsonDecode(data);
  //       ArticlesList articles = ArticlesList.fromJson(jsonData);
  //       List<Article> articlesList =
  //           articles.articles.map((e) => Article.fromJson(e)).toList();
  //       return articlesList;
  //     } else {
  //       print('status code = ${response.statusCode}');
  //     }
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   return [];
  // }
//}
