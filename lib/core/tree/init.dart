import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/core/data/person.dart';
import 'package:tree_view/core/tree/utils.dart';
import 'package:tree_view/core/tree/node.dart';

final _rootData = data.first;

final Node<Person> _nodeRoot = Node<Person>(
  id: _rootData.id,
  data: _rootData,
);

Node<Person> nodeRoot() {
  final TreeUtils<Person> treeInstance = TreeUtils.instance<Person>(_nodeRoot);
  for (final d in data) {
    Node<Person> node = Node<Person>(
      id: d.id,
      data: d,
    );

    Node<Person>? nodeParent = treeInstance.bfsTraversal(
      rootNode: _nodeRoot,
      predicate: (innerNode) {
        return innerNode.id == d.parentId;
      },
    );

    if (nodeParent != null) {
      nodeParent.children!.addChild(node);
      node.parent = nodeParent;
    }
  }

  return _nodeRoot;
}
