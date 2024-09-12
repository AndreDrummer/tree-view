import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

class NodeData<T> {
  final T? data;
  final dynamic id;

  NodeData({
    this.data,
    required this.id,
  });

  @override
  String toString() {
    return 'id: $id -> ${data.toString()}\n';
  }
}

class EmptyNodeData extends ParentProtocol {
  @override
  get id => 0;

  @override
  get parentId => 0;
}
