import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/ModelPicture.dart';
import 'PictureEvent.dart';
import 'PictureState.dart';
import 'ApiRepository.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc(this.repository) : super(PictureInitial());

  int page = 1;
  final ApiRepository repository;

  void loadPhoto() {
    if (state is PictureLoading) return;

    final currentState = state;

    var oldPhoto = <ModelPicture>[];
    if (currentState is PictureLoaded) {
      oldPhoto = currentState.photoModel;
    }

    emit(PictureLoading(oldPhoto, isFirstFetch: page == 1));

    repository.fetchPictureList(page).then((newPhoto) {
      page++;

      final photos = (state as PictureLoading).oldPhoto;
      photos.addAll(newPhoto);

      emit(PictureLoaded(photos));
    });
  }
}
