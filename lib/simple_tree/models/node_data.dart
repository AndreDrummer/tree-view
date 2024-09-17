import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

class NodeData<T> {
  final dynamic id;
  final T? data;

  NodeData({
    required this.id,
    this.data,
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
