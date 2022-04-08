import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'model/ModelPicture.dart';

class Get_api {
  Future<List<ModelPicture>> fetchPictures(int number_page) async {
    String unSplash =
        "https://api.unsplash.com/search/photos/?client_id=pwdIZ_XcUDFVHdJ2Jqscl7pwvUz31J2PVIc8Ztzp6jU&query=Random&per_page=20&page=${number_page}";
    List<ModelPicture> modelPic = [];

    http.Response response = await http.get(Uri.parse(unSplash));
    var body = json.decode(response.body);
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200 || body != null) {
        number_page += 10;
        for (var item in body['results']) {
          modelPic.add(ModelPicture.fromJson(item));
        }

        return modelPic;
      }
      return null!;
    } catch (e) {
      print(e);
      return null!;
    }
  }
}
