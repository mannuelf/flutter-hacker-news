import 'package:flutter/material.dart';
import 'package:newz/src/blocs/stories_provider.dart';
import '../models/item.dart';
import '../blocs/stories_bloc.dart';

class NewsListTile extends StatelessWidget {
  final int itemId; // passed in by parent widget

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
  }
}
