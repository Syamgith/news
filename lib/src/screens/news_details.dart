import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/comment.dart';

class NewsDetails extends StatelessWidget {
  final itemId;
  NewsDetails({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    List<Widget> children = [buildTitle(item)];
    List<Widget> commentList = item.kids
        .map((kidId) => Comment(
              itemId: kidId,
              itemMap: itemMap,
            ))
        .toList();
    children.addAll(commentList);
    return ListView(
      children: children,
    );
  }

  buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
