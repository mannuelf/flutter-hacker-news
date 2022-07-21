import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>(); // Observable of RXDart
  final _items = BehaviorSubject<int>();

  // Getter to Streams
  // https://stackoverflow.com/questions/59336428/observable-is-deprecated-in-rxdart-0-23-1
  Stream<List<int>> get topIds => _topIds.stream;

  Function(int) get fetchItem => _items.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _ItemsTransformer() {
    // cache is the emitted event object, id is the id of the item, index is the iteration of transformed items
    return ScanStreamTransformer((cache, int id, _) async {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
