import 'package:tree_view/core/tree/node.dart';
import 'dart:collection';

class TreeUtils {
  static Node<T>? bfsTraversal<T extends TOString>({
    bool Function(Node<T>)? predicate,
    void Function(dynamic)? process,
    required Node<T> rootNode,
  }) {
    // Initialize a queue and add the root node
    Queue<Node<T>> queue = Queue<Node<T>>();
    Node<T> currentNode = rootNode;
    queue.add(rootNode);

    // Traverse while there are nodes in the queue
    while (queue.isNotEmpty) {
      // Dequeue the front node
      Node<T> current = queue.removeFirst();
      currentNode = current;

      // If process is not null, process the current node
      process?.call(current);

      // If a predicate function is past, runs it agains the currentNode and returns appropriately
      if (predicate != null && predicate(current)) return currentNode;

      // Enqueue all children of the current node
      for (var child in current.children!) {
        queue.add(child);
      }
    }

    return null;
  }
}
