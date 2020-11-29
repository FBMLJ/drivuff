import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/Usuario.dart';
import 'package:flutter_app/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/models/file-item.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FileRepository {
  final firestoreInstance = FirebaseFirestore.instance;


  Future<List<Fileitem>> getUploadFiles() async {

      Fileitem fileitem = new Fileitem();
      List<Fileitem> files = new List();
      firestoreInstance.collection("users").get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          print(result.data());
          fileitem.id = result["id"];
          fileitem.title = result["title"];
          fileitem.filetype = result["filetype"];
          fileitem.aprovedbyadmin = result["aprovedbyadmin"];
          fileitem.url = result["url"];
          //fileitem.date = result["date"];
          fileitem.done = result["done"];
          //;
          files.add(fileitem);
        });
      });
      return (files);
  }

  Future<List<Fileitem>> getDownloadFiles() async {
    //var url = "https://10.0.2.2:5001/v1/file/download";
    var url = "gs://backmovel-f67cd.appspot.com/v1/file/download";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Usuario().idUsuario}'},
      ),
    );
    return (response.data as List)
        .map((files) => Fileitem.fromJson(files))
        .toList();
  }

  Future<List<Fileitem>> getAll() async {
    //var url = "https://10.0.2.2:5001/v1/file/all";
    var url = "gs://backmovel-f67cd.appspot.com/v1/file/all";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Usuario().idUsuario}'},
      ),
    );
    return (response.data as List)
        .map((files) => Fileitem.fromJson(files))
        .toList();
  }


  Future<Fileitem> add(Fileitem item) async {
    firestoreInstance.collection("users").add(
        {
          "id" : item.id,
          "done" : item.done,
          "date" : item.date,
          "url" : item.url,
          "title": item.title,
          "aprovedbyadmin": item.aprovedbyadmin,
          "filetype" : item.filetype,

        }).then((value){
      print(value.id);
    });
  }

  Future<Fileitem> markAsApproved(Fileitem item) async {
    //var url = "https://10.0.2.2:5001/v1/file/mark-as-approved";
    var url = "gs://backmovel-f67cd.appspot.com/v1/file/mark-as-approved";
    try {
      Response response = await Dio().put(
        url,
        data: item,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${Usuario().idUsuario}'},
        ),
      );
      return Fileitem.fromJson(response.data["data"]);
    } catch (e) {
      return null;
    }
  }
}
