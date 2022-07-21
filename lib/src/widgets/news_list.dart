import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../models/item.dart';

class NewsListTile extends StatelessWidget {
  final int itemId; // passed in by parent widget

  NewsListTile({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        print('💵 Widgets: news_list.dart');
        print(snapshot.data);
        if (snapshot.data == null || !snapshot.hasData) {
          return const Text('Stream still loading');
        }
        return FutureBuilder(
            future: snapshot.data![itemId],
            builder:
                ((BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (itemSnapshot.data == null) {
                return Text('Still loading ${itemSnapshot.data!.id}');
              }

              return Text(itemSnapshot.data!.title);
            }));
      },
    );
  }
}
