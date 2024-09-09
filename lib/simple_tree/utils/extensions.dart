import 'package:tree_view/simple_tree/models/node_data.dart';

extension DataToNodeData<T> on T {
  NodeData<T> toNodeData(int id) {
    return NodeData<T>(
      data: this,
      id: id,
    );
  }
}

extension DataListToNodeDataList<T> on List<T> {
  List<NodeData<T>> toNodeDataList() {
    return asMap().entries.map((entry) {
      final index = entry.key;
      final element = entry.value;

      return element.toNodeData(index);
    }).toList();
  }
}
