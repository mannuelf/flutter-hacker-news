import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  // Getter to Streams
  // https://stackoverflow.com/questions/59336428/observable-is-deprecated-in-rxdart-0-23-1
  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _ItemsTransformer() {
    return ScanStreamTransformer(() {}, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
  }
}
