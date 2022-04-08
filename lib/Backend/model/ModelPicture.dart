import 'dart:convert';
class ModelPicture{

  String id, image,urldownload;
  ModelPicture( this.id, this.image,this.urldownload);




  factory ModelPicture.fromJson(Map<String,dynamic> map) =>ModelPicture(
    map['id'] ??'3',
    map['urls']['small'] ,
    map['links']['download'],
  );
}