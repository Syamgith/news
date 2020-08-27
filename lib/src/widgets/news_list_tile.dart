import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading stream');
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData) {
              return Text('Loading Item $itemId');
            }
            return Text('j');
          },
        );
      },
    );
  }
}
