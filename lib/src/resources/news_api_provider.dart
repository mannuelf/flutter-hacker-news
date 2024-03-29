import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' show Client;

import '../models/item.dart';
import './repository.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    // dart only sees the list, cannot see the type, so you can cast
    final ids = await json.decode(response.body);
    return await ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = await json.decode(response.body);
    // give back an Instance of ItemModel
    return ItemModel.fromJson(parsedJson);
  }
}
