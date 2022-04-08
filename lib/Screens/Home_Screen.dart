import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:unsplash/Screens/PictureGrid.dart';
import '../Backend/FeatchPictureBloc/Picture_Bloc.dart';
import '../Backend/FeatchPictureBloc/PictureState.dart';
import '../Backend/model/ModelPicture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/Screens/Appbar.dart';

class HomeScreen extends StatelessWidget {
  static List<ModelPicture> favorite = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PictureBloc>(context).loadPhoto();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140), child: Appbar()),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PictureBloc, PictureState>(builder: (context, state) {
      if (state is PictureLoading && state.isFirstFetch) {
        return const Center(child: CircularProgressIndicator());
      }

      List<ModelPicture> photos = [];
      bool isLoading = false;

      if (state is PictureLoading) {
        photos = state.oldPhoto;
        isLoading = true;
      } else if (state is PictureLoaded) {
        photos = state.photoModel;
      }

      return PictureGrid(
        model: photos,
        isLoading: isLoading,
        isSearch: false,
      );
    });
  }
}
