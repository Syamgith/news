import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();
  Stream<Map<int, Future<ItemModel>>> items;

  //getters to stream
  Stream<List<int>> get topIds => _topIds.stream;
  StoriesBloc() {
    items = _items.stream.transform(_itemsTranformer());
  }

  //getter to sink
  get fetchItem => _items.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.add(ids);
  }

  _itemsTranformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
