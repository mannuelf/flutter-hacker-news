import 'package:flutter/material.dart';

import '../blocs/stories_bloc.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // thing.of(context) gives us access to data up n down the widget tree
    // we get access to the stream and get to use the data
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TOP NEWS'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {}
}
