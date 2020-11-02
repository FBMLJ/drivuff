import 'package:mobx/mobx.dart';
import 'package:flutter_app/models/file-item.model.dart';
part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  String currentState = "none";

  @observable
  bool busy = false;

  @observable
  ObservableList<Fileitem> files = new ObservableList<Fileitem>();

  @action
  void changeSelected(String state) {
    currentState = state;
  }

  @action
  void add(Fileitem item) {
    files.add(item);
  }

  @action
  void setFiles(List<Fileitem> items) {
    files.addAll(items);
  }

  @action
  void clearFiles() {
    files = new ObservableList<Fileitem>();
  }
}
