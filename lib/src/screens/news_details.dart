import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';

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

  buildBody(CommentsBloc bloc) {}
}
