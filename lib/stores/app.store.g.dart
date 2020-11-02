// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$currentStateAtom = Atom(name: '_AppStore.currentState');

  @override
  String get currentState {
    _$currentStateAtom.context.enforceReadPolicy(_$currentStateAtom);
    _$currentStateAtom.reportObserved();
    return super.currentState;
  }

  @override
  set currentState(String value) {
    _$currentStateAtom.context.conditionallyRunInAction(() {
      super.currentState = value;
      _$currentStateAtom.reportChanged();
    }, _$currentStateAtom, name: '${_$currentStateAtom.name}_set');
  }

  final _$busyAtom = Atom(name: '_AppStore.busy');

  @override
  bool get busy {
    _$busyAtom.context.enforceReadPolicy(_$busyAtom);
    _$busyAtom.reportObserved();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.context.conditionallyRunInAction(() {
      super.busy = value;
      _$busyAtom.reportChanged();
    }, _$busyAtom, name: '${_$busyAtom.name}_set');
  }

  final _$filesAtom = Atom(name: '_AppStore.files');

  @override
  ObservableList<Fileitem> get files {
    _$filesAtom.context.enforceReadPolicy(_$filesAtom);
    _$filesAtom.reportObserved();
    return super.files;
  }

  @override
  set files(ObservableList<Fileitem> value) {
    _$filesAtom.context.conditionallyRunInAction(() {
      super.files = value;
      _$filesAtom.reportChanged();
    }, _$filesAtom, name: '${_$filesAtom.name}_set');
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void changeSelected(String state) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.changeSelected(state);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(Fileitem item) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.add(item);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiles(List<Fileitem> items) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.setFiles(items);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFiles() {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.clearFiles();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }
}
