import 'dart:async';
import 'package:newz/src/resourses/news_db.dart';

import 'news_api_provider.dart';
import 'news_api_provider.dart';
import '../models/item.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {}

  fetchItem() {}
}
