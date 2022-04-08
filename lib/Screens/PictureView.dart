import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:unsplash/Backend/model/ModelPicture.dart';

class PictureView extends StatelessWidget {
  List<ModelPicture> model;
  int index;
  bool visible;

  PictureView(
      {required this.model, required this.index, required this.visible});

  void downloadImage(String url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url,
          destination: AndroidDestinationType.custom(
              directory: 'Unsplash', inPublicDir: true)
            ..inExternalFilesDir());
      if (imageId == null) {
        return;
      }
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    FocusManager.instance.primaryFocus?.unfocus();
    return Stack(children: [
      Container(
          width: screenWidth,
          height: screenHeight,
          child: Image.network(
            model[index].image,
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
        body: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Center(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight / 1.3,
                child: Image.network(
                  model[index].image,
                  fit: BoxFit.contain,
                  width: screenWidth,
                  height: screenHeight,
                ),
              ),
            ),
            visible == true
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () =>
                                downloadImage(model[index].urldownload),
                            child: const Text('DOWNLOAD'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
                      ),
                    ),
                  )
                : const Text(''),
          ],
        ),
      )
    ]);
  }
}
