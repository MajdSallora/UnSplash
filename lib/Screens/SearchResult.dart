import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/Backend/model/ModelPicture.dart';
import 'package:unsplash/Backend/search/SearchBloc.dart';
import 'package:unsplash/Backend/search/SearchEvent.dart';
import 'package:unsplash/Backend/search/SearchState.dart';
import 'Appbar.dart';
import 'PictureGrid.dart';

class SearchResult extends StatelessWidget {
  SearchBloc searchBloc;

  SearchResult({required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    String? queryString;
    queryString = Appbar.query;
    searchBloc.add(Search(query: Appbar.query));

    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          List<ModelPicture> photos = [];
          bool isLoading = false;
          if (Appbar.query == '') {
            return const Center(
                child: Text('Please enter any word in search box'));
          }
          if (state is SearchUninitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SearchLoading) {
            photos = state.oldPhoto;
            isLoading = true;
          }
          if (state is SearchError) {
            return const Center(
              child: Text('Failed To Load'),
            );
          }
          if (state is SearchLoaded) {
            photos = state.photos;
            if (state.photos.isEmpty) {
              return const Center(
                child: Text('No Results'),
              );
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Search result : ' + Appbar.query),
              backgroundColor: Colors.redAccent,
            ),
            body: PictureGrid(
              model: photos,
              isLoading: isLoading,
              isSearch: true,
            ),
          );
        },
      ),
    );
  }
}
