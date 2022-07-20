import 'dart:async';
import 'package:newz/src/resourses/news_db.dart';

import 'news_api_provider.dart';
import 'news_api_provider.dart';
import '../models/item.dart';

// proxy to db, calls providers, app should not call providers directly
class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) async {
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
