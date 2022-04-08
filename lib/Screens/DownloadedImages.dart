import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DownloadedPic extends StatefulWidget {
  @override
  _DownloadedPicState createState() => _DownloadedPicState();
}

class _DownloadedPicState extends State<DownloadedPic> {
  final Directory _photoDir = Directory(
      '/storage/emulated/0/Android/data/com.majd.unsplash/files/Unsplash');

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Downloaded Images"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: const Center(
            child: Text(
              "All Downloaded images should appear here",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);

      if (imageList.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Downloaded Images",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black45),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: 60.0),
            child: StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return Material(
                  elevation: 8.0,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        return Stack(children: [
                          Container(
                              width: screenWidth,
                              height: screenHight,
                              child: Image.file(
                                File(imgPath),
                                fit: BoxFit.cover,
                              )),
                          ClipRRect(
                            // Clip it cleanly.
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.grey.withOpacity(0.1),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: screenWidth,
                                    height: screenHight / 1.3,
                                    child: Image.file(
                                      File(imgPath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                        ]);
                      }));
                    },
                    child: Hero(
                      tag: imgPath,
                      child: Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Downloaded images"),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: const Text(
                "Sorry, No Images Where Found.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      }
    }
  }
}
