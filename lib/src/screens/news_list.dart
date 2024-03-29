import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart' show StoriesBloc, StoriesProvider;
import '../widgets/news_list.dart';

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
        title: const Text('📰 HACKERNEWS'),
        backgroundColor: Colors.amber[900],
      ),
      body: buildList(bloc),
    );
  }

  // Arguments StoriesBloc bloc is how we get the bloc of data into said widget.
  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: ((BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        print('screens/news_list.dart');
        print(snapshot.data);
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: ((BuildContext context, int index) {
            return NewsListTile(
              itemId: snapshot.data![index],
            );
          }),
        );
      }),
    );
  }
}
