import 'dart:io';
import 'package:flutter_app/components/Usuario.dart';
import 'package:flutter_app/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/models/file-item.model.dart';

class FileRepository {
  Future<List<Fileitem>> getUploadFiles() async {

    //var url = "https://10.0.2.2:5001/v1/file/upload";
    var url = "gs://backmovel-f67cd.appspot.com/v1/file/upload";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Usuario().idUsuario}'}, //user.token
      ),
    );
    return (response.data as List)
        .map((files) => Fileitem.fromJson(files))
        .toList();
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
    //var url = "https://10.0.2.2:5001/v1/file/upload";
    var url = "gs://backmovel-f67cd.appspot.com/v1/file/upload";
    try {
      Response response = await Dio().post(
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
