import 'package:unsplash/Backend/api.dart';
import '../model/ModelPicture.dart';

class ApiRepository {
  final _provider = Get_api();

  Future<List<ModelPicture>> fetchPictureList(int page) {
    return _provider.fetchPictures(page);
  }
}
class NetworkError extends Error {}
