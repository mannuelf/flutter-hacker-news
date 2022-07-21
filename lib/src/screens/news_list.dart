import 'dart:async';

import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOP NEWS'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: ((context, index) {
        // simulate fetching data from repository
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
                height: 80.0,
                child: snapshot.hasData
                    ? Text('Im visible $index')
                    : Text('I have not fetched data yet $index'));
          },
        );
      }),
    );
  }

  getFuture() {
    return Future.delayed(const Duration(seconds: 2), (() => 'Hi ho'));
  }
}
