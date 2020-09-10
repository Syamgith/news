import 'package:news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;
  //Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.add;
  despose() {
    _commentsFetcher.close();
    _commentsFetcher.close();
  }
}
