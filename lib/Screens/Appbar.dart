import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/Backend/search/SearchBloc.dart';
import 'package:unsplash/Backend/search/SearchState.dart';
import 'package:unsplash/Screens/SearchResult.dart';
import 'DownloadedImages.dart';
import 'Favorite.dart';

class Appbar extends StatefulWidget {
  static String query = "";

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  var textEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context);
    textEditingController.clear();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Column(
        children: [
          AppBar(
            title: RichText(
                text: const TextSpan(
                    text: 'Un',
                    style: TextStyle(color: Colors.redAccent, fontSize: 24),
                    children: [
                  TextSpan(
                      text: 'Splash',
                      style: TextStyle(color: Colors.black45, fontSize: 20))
                ])),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Favorite()));
                  },
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DownloadedPic()));
                  },
                  child: const Icon(
                    Icons.save,
                    color: Colors.redAccent,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(
                              searchBloc:
                                  BlocProvider.of<SearchBloc>(context))));
                  textEditingController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (value) {
                  Appbar.query = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 10, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.search,
                      size: 33,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(
                                  searchBloc:
                                      BlocProvider.of<SearchBloc>(context))));
                      textEditingController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
              ),
            ]),
          ),
        ],
      );
    });
  }
}
