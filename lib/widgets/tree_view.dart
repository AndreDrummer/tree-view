import 'package:tree_view/models/person.dart';
import 'package:tree_view/widgets/line_bread_crumb.dart';
import 'package:tree_view/widgets/node_row.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../models/node.dart';

class TreeView extends StatelessWidget {
  const TreeView(this.node, {super.key, this.toggleNodeView});
  final void Function(Node<Person> node)? toggleNodeView;
  final Node<Person> node;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  @override
  Widget build(BuildContext context) {
    final nodeRow = NodeRow(node, onPressed: () => toggleNodeView?.call(node));
    // return Table(child: nodeRow);
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NodeRow(node, onPressed: () => toggleNodeView?.call(node)),
          Visibility(
            visible: node.expanded,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineBreadCrumb(lineBreadCrumbHeight()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children.map((child) {
                    return TreeView(
                      child,
                      toggleNodeView: (node) => toggleNodeView?.call(node),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Table extends StatelessWidget {
  const Table({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      cellBuilder: (ctx, vinicity) => _buildCell(ctx, vinicity, child),
      columnCount: 20,
      columnBuilder: _buildColumnSpan,
      rowCount: 20,
      rowBuilder: _buildRowSpan,
    );
  }

  TableViewCell _buildCell(
      BuildContext context, TableVicinity vicinity, Widget child) {
    return TableViewCell(
      child: child,
    );
  }

  TableSpan _buildColumnSpan(int index) {
    const TableSpanDecoration decoration = TableSpanDecoration(
      border: TableSpanBorder(
        trailing: BorderSide(),
      ),
    );

    switch (index % 5) {
      case 0:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(100),
          onEnter: (_) => print('Entered column $index'),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer t) =>
                  t.onTap = () => print('Tap column $index'),
            ),
          },
        );
      case 1:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FractionalTableSpanExtent(0.5),
          onEnter: (_) => print('Entered column $index'),
          cursor: SystemMouseCursors.contextMenu,
        );
      case 2:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(120),
          onEnter: (_) => print('Entered column $index'),
        );
      case 3:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(145),
          onEnter: (_) => print('Entered column $index'),
        );
      case 4:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(200),
          onEnter: (_) => print('Entered column $index'),
        );
    }
    throw AssertionError(
      'This should be unreachable, as every index is accounted for in the '
      'switch clauses.',
    );
  }

  TableSpan _buildRowSpan(int index) {
    final TableSpanDecoration decoration = TableSpanDecoration(
      color: index.isEven ? Colors.purple[100] : null,
      border: const TableSpanBorder(
        trailing: BorderSide(
          width: 3,
        ),
      ),
    );

    switch (index % 3) {
      case 0:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(50),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer t) =>
                  t.onTap = () => print('Tap row $index'),
            ),
          },
        );
      case 1:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(65),
          cursor: SystemMouseCursors.click,
        );
      case 2:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FractionalTableSpanExtent(0.15),
        );
    }
    throw AssertionError(
      'This should be unreachable, as every index is accounted for in the '
      'switch clauses.',
    );
  }
}
