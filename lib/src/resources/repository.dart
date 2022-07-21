import 'dart:async';

import '../models/item.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

// proxy to db, calls providers, app should not call providers directly
class Repository {
  List<Source> sources = <Source>[newsDbProvider, NewsApiProvider()];
  List<Cache> caches = <Cache>[newsDbProvider];

  // Iterate over sources when dbprovider get fetchTopIds implemented.
  Future<List<int>> fetchTopIds() {
    // similar to fetch item loop through all sources and set ids if found
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    late ItemModel item;
    late Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      // ignore: unnecessary_null_comparison
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
