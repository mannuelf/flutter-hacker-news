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

    // Temp, very bad don't do this
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TOP NEWS'),
      ),
      body: buildList(bloc),
    );
  }

  // Arguments StoriesBloc bloc is how we get the bloc of data into said widget.
  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: ((BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Still waiting on ids');
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: ((BuildContext context, int index) {
            return Text('${snapshot.data![index]}');
          }),
        );
      }),
    );
  }
}
