import 'package:tree_view/core/tree/utils.dart';
import 'package:tree_view/data/person.dart';
import 'package:tree_view/core/node/node.dart';
import 'package:tree_view/models/person.dart';

final _rootData = data.first;

final Node<Person> _nodeRoot = Node<Person>(
  id: _rootData.id,
  data: _rootData,
);

Node<Person> nodeRoot() {
  for (final d in data) {
    Node<Person> node = Node<Person>(
      id: d.id,
      data: d,
    );

    Node<Person>? nodeParent = TreeUtils.bfsTraversal<Person>(
      rootNode: _nodeRoot,
      predicate: (innerNode) {
        return innerNode.id == d.parentId;
      },
    );

    if (nodeParent != null) node.parent = nodeParent;
    nodeParent?.children!.addChild(node);
  }

  return _nodeRoot;
}
