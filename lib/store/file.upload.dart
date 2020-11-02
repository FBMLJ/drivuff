import 'dart:io';

//import 'package:firestorage_demo/imageviewer.dart';
import 'package:firebase_image/firebase_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/controlles/file.controller.dart';
import 'package:flutter_app/models/file-item.model.dart';
import 'package:flutter_app/screen/Home.dart';
import 'package:flutter_app/stores/app.store.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Fileupload extends StatefulWidget {
  @override
  _FileuploadState createState() => _FileuploadState();
}

class _FileuploadState extends State<Fileupload> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = new DateFormat('dd/MM/yyyy');

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;

  String result = '';

  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("images/$filename");
    }
    if (fileType == 'audio') {
      storageReference =
          FirebaseStorage.instance.ref().child("audio/$filename");
    }
    if (fileType == 'video') {
      storageReference =
          FirebaseStorage.instance.ref().child("videos/$filename");
    }
    if (fileType == 'pdf') {
      storageReference =
          FirebaseStorage.instance.ref().child("pdf/$filename");
    }
    if (fileType == 'others') {
      storageReference =
          FirebaseStorage.instance.ref().child("others/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'audio') {
        file = await FilePicker.getFile(type: FileType.AUDIO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'video') {
        file = await FilePicker.getFile(type: FileType.VIDEO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.ANY);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    final controller = new FileController(store);

    return ListView(padding: EdgeInsets.only(left: 40),
          children: <Widget>[
            ListTile(
              title: Text('Image', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.image, color: Colors.black,),
              onTap: () {
                setState(() {
                  fileType = 'image';
                });
                filePicker(context);
                var item = new Fileitem(
                  title: fileName,
                  date: DateTime.now(),
                  filetype: "image",
                  id:fileName,
                  done: true,
                  aprovedbyadmin: false,
                  url: "images/filename",
                );
                controller.add(item).then((_){});
              },
            ),
            ListTile(
              title: Text('Audio', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.audiotrack, color: Colors.black,),
              onTap: () {
                setState(() {
                  fileType = 'audio';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('Video', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.video_label, color: Colors.black,),
              onTap: () {
                setState(() {
                  fileType = 'video';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('PDF', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.pages, color: Colors.black,),
              onTap: () {
                setState(() {
                  fileType = 'pdf';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('Others', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.attach_file, color: Colors.black,),
              onTap: () {
                setState(() {
                  fileType = 'others';
                });
                filePicker(context);
              },
            ),
            SizedBox(height: 50,),
            Text(result, style: TextStyle(color: Colors.blue),)
          ],
        );
  }
}

