import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/Backend/model/ModelPicture.dart';
import 'package:unsplash/Backend/search/SearchResp.dart';
import 'package:unsplash/Backend/search/SearchState.dart';
import 'SearchEvent.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.pictureRepository}) : super(SearchUninitialized()) {
    on<Search>(onTextChanged);
  }

  final SearchRepository pictureRepository;
  static int page = 1;

  void onTextChanged(Search event, Emitter<SearchState> emit) async {
    final currentState = state;
    final searchTerm = event.query;

    if (searchTerm.isEmpty) return emit(SearchUninitialized());

    if (state is SearchLoading) return;
    var oldPhoto = <ModelPicture>[];

    if (currentState is SearchLoaded) {
      oldPhoto = currentState.photos;
    }

    emit(SearchLoading(oldPhoto));
    if (page == 1) {
      oldPhoto.clear();
    }

    try {
      await pictureRepository.searchPictures(searchTerm, page).then((newPhoto) {
        page++;
        final photos = (state as SearchLoading).oldPhoto;
        photos.addAll(newPhoto);
        emit(SearchLoaded(photos: photos));
      });
    } catch (error) {
      print(error);
    }
  }
}
