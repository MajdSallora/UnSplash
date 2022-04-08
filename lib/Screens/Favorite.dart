import 'package:flutter/material.dart';
import 'package:unsplash/Screens/Home_Screen.dart';
import 'Home_Screen.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black45),
        title: const Text(
          'Favorites',
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: HomeScreen.favorite.isEmpty == false
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: HomeScreen.favorite.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      HomeScreen.favorite.removeAt(index);
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black12, width: 3.0),
                            borderRadius: BorderRadius.circular(25)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              HomeScreen.favorite[index].image,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            )),
                      )),
                );
              })
          : const Center(
              child: Text(
              'Double tap in picture to add in favorite',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            )),
    );
  }
}
