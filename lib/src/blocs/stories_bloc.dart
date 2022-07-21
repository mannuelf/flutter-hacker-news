import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>(); // Observable of RXDart
  final _items = BehaviorSubject<int>();
  // instance var that will hold the transformed streams
  late Stream<Map<int, Future<ItemModel>>> items;

  // Getter to Streams
  // https://stackoverflow.com/questions/59336428/observable-is-deprecated-in-rxdart-0-23-1
  Stream<List<int>> get topIds => _topIds.stream;

  // Function(int) get fetchItem => _items.sink.add;
  // BAD practice, every widget will get their own cache copy
  // get items => _items.stream.transform(_ItemsTransformer());

  // need to expose items to the outside world only one time

  StoriesBloc() {
    // does not modify originally stream, a new stream is created and we want it
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    // cache is the emitted event object, id is the id of the item, index is the iteration of transformed items
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
