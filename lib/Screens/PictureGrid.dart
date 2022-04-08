import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/Backend/FeatchPictureBloc/Picture_Bloc.dart';
import 'package:unsplash/Backend/search/SearchBloc.dart';
import 'package:unsplash/Backend/search/SearchEvent.dart';
import 'package:unsplash/Screens/LikeAnimation.dart';
import 'package:unsplash/Screens/PictureView.dart';
import '../Backend/model/ModelPicture.dart';
import 'Appbar.dart';
import 'Home_Screen.dart';

class PictureGrid extends StatefulWidget {
  List<ModelPicture> model;
  bool isLoading;
  bool isSearch;

  PictureGrid({required this.model, required this.isLoading,required this.isSearch});

  @override
  State<PictureGrid> createState() => _PictureGridState();
}

class _PictureGridState extends State<PictureGrid> {
  final scrollController = ScrollController();

  bool isAnimating = false;
  int sellectedindex = 0;

  void setupScrollController(context) async {
    SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          print('end scroll');
          if(widget.isSearch == true){
            String? queryString;
            queryString = Appbar.query;
            searchBloc.add(Search(query: Appbar.query));
            BlocProvider.of<SearchBloc>(context);
          }
          else{
            BlocProvider.of<PictureBloc>(context).loadPhoto();

          }

        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    SearchBloc.page = 1;
    Appbar.query = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < widget.model.length) {
                    return GestureDetector(
                      onDoubleTap: () {
                        if (HomeScreen.favorite
                            .contains(widget.model.elementAt(index))) {
                          HomeScreen.favorite
                              .remove(widget.model.elementAt(index));
                        } else {
                          HomeScreen.favorite
                              .add(widget.model.elementAt(index));
                        }
                        setState(() {});
                        sellectedindex = index;
                        isAnimating = true;
                      },
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PictureView(
                            model: widget.model,
                            index: index,
                            visible: true,
                          );
                        }));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.black12, width: 3.0),
                                    borderRadius: BorderRadius.circular(25)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      widget.model[index].image,
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                    )),
                              ),
                              Opacity(
                                opacity: isAnimating ? 1 : 0,
                                child: AnimationButtonLike(
                                    index: index,
                                    selectedindex: sellectedindex,
                                    isAnimating: isAnimating,
                                    duration: const Duration(milliseconds: 700),
                                    onEnd: () => setState(() {
                                          isAnimating = false;
                                        }),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red[200],
                                      size: 100,
                                    )),
                              )
                            ],
                          )),
                    );
                  }
                },
                    childCount:
                        widget.model.length + (widget.isLoading ? 1 : 0))),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              if (widget.isLoading == true) {
                Timer(const Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent - 180);
                });
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                );
              }
            }, childCount: 1))
          ],
        ));
  }
}
