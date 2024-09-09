class NodeData<T> {
  final T data;
  final int id;

  NodeData({
    required this.data,
    required this.id,
  });

  @override
  String toString() {
    return 'id: $id -> ${data.toString()}\n';
  }
}
