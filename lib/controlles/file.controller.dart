import 'package:flutter_app/models/file-item.model.dart';
import 'package:flutter_app/repositories/file.repository.dart';
import 'package:flutter_app/stores/app.store.dart';

class FileController {
  AppStore _store;
  FileRepository _repository;

  FileController(AppStore store) {
    _store = store;
    _repository = new FileRepository();
  }

  void changeSelection(String selection) {
    _store.clearFiles();

    switch (selection) {
      case "upload":
        {
          _store.busy = true;
          _store.clearFiles();
          _store.changeSelected("upload");
          _repository.getUploadFiles().then((data) {
            _store.setFiles(data);
            _store.busy = false;
          });
          return;
        }

      case "download":
        {
          _store.busy = true;
          _store.clearFiles();
          _store.changeSelected("download");
          _repository.getDownloadFiles().then((data) {
            _store.setFiles(data);
            _store.busy = false;
          });
          return;
        }

      case "all":
        {
          _store.busy = true;
          _store.clearFiles();
          _store.changeSelected("all");
          _repository.getAll().then((data) {
            _store.setFiles(data);
            _store.busy = false;
          });
          return;
        }
    }
  }

  Future add(Fileitem item) async {
    _store.busy = true;
    await _repository.add(item);
    _store.busy = false;
    changeSelection(_store.currentState);
  }

  Future markAsApproved(Fileitem item) async {
    _store.busy = true;
    await _repository.markAsApproved(item);
    _store.busy = false;
    changeSelection(_store.currentState);
  }
}
