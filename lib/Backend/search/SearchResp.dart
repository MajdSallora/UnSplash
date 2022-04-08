import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/ModelPicture.dart';

abstract class SearchRepository {
  Future<List<ModelPicture>> searchPictures(String query, int page);
}

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<List<ModelPicture>> searchPictures(String query, int page) async {
    String unSplash =
        "https://api.unsplash.com/search/photos/?client_id=pwdIZ_XcUDFVHdJ2Jqscl7pwvUz31J2PVIc8Ztzp6jU&query=${query}&per_page=30&page=${page}";

    var response = await http.get(Uri.parse(unSplash));
    if (response.statusCode == 200) {
      List<ModelPicture> modelPic = [];

      var data = json.decode(response.body);
      for (var item in data['results']) {
        modelPic.add(ModelPicture.fromJson(item));
      }

      return modelPic;
    } else {
      throw Exception('Failed');
    }
  }
}
