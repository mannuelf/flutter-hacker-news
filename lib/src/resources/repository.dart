import 'dart:async';

import '../models/item.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

// proxy to db, calls providers, app should not call providers directly
class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    // var is mutable.
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    // find the item and save it locally here
    item = await apiProvider.fetchItem(id);
    // attempt to add to our database
    await dbProvider.addItem(item);

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
