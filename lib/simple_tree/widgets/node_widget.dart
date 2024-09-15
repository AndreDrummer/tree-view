import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/builder.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:get/get.dart' hide Node;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NodeWidget<T> extends StatefulWidget {
  const NodeWidget(
    this.node, {
    required this.showCustomizationForRoot,
    required this.breadCrumbLineColor,
    required this.elementsColor,
    required this.nodeRowConfig,
    required this.nodeRootId,
    super.key,
  });

  final NodeRowConfig Function(T) nodeRowConfig;
  final Node<NodeData<T>> node;

  final bool showCustomizationForRoot;
  final Color breadCrumbLineColor;
  final Color elementsColor;
  final int nodeRootId;

  @override
  State<NodeWidget<T>> createState() => _NodeWidgetState<T>();
}

class _NodeWidgetState<T> extends State<NodeWidget<T>> {
  late Node<NodeData<T>> node;

  @override
  void initState() {
    node = widget.node;

    super.initState();
  }

  bool showCustomization() {
    if (node.id == widget.nodeRootId) {
      return widget.showCustomizationForRoot;
    }
    return true;
  }

  void toggleNode() {
    setState(() {
      node = node.expanded ? node.close() : node.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    NodeRowConfig? nodeConfig;

    if (node.value?.data != null) {
      nodeConfig = widget.nodeRowConfig(node.value!.data as T);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: node.getHeightFromNodeToRoot * 20),
              width: node.getHeightFromNodeToRoot > 0 ? 1 : 0,
              color: widget.breadCrumbLineColor,
              height: 48,
            ),
            Visibility(
              visible: node.hasChildren,
              replacement: Container(
                color: widget.breadCrumbLineColor,
                width: 48,
                height: 1,
              ),
              child: IconButton(
                onPressed: toggleNode,
                icon: Icon(
                  !node.hasChildren || !node.expanded
                      ? Icons.keyboard_arrow_right_outlined
                      : Icons.keyboard_arrow_down,
                  color: widget.elementsColor,
                ),
              ),
            ),
            _prefixIcon(context, nodeConfig, widget.showCustomizationForRoot),
            TextButton(
              onPressed: toggleNode,
              child: Text(
                "${nodeConfig?.title}",
                style: TextStyle(color: widget.elementsColor, fontSize: 18),
              ),
            ),
            _suffixIcon(context, nodeConfig, widget.showCustomizationForRoot),
          ],
        ),
        Visibility(
            visible: node.expanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: node.children!.map((nodeChild) {
                return builder(
                  nodeChild,
                  showCustomizationForRoot: widget.showCustomizationForRoot,
                  breadCrumbLinesColor: widget.breadCrumbLineColor,
                  nodeRowConfig: widget.nodeRowConfig,
                  elementsColor: widget.elementsColor,
                  nodeRootId: widget.nodeRootId,
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _suffixIcon(
    BuildContext context,
    NodeRowConfig? nodeConfig,
    bool showCustomizationForRoot,
  ) {
    if (nodeConfig != null &&
        nodeConfig.suffixIcon != null &&
        showCustomizationForRoot) {
      final Color? iconColor =
          nodeConfig.suffixIconColor ?? Get.theme.iconTheme.color;

      return Icon(nodeConfig.suffixIcon!,
          color: iconColor, size: nodeConfig.suffixIconSize);
    }
    return Container();
  }

  Widget _prefixIcon(
    BuildContext context,
    NodeRowConfig? nodeConfig,
    bool showCustomizationForRoot,
  ) {
    if (nodeConfig != null &&
        nodeConfig.prefixIcon != null &&
        showCustomizationForRoot) {
      final Color? iconColor =
          nodeConfig.prefixIconColor ?? Get.theme.iconTheme.color;

      final Widget svg = SvgPicture.asset(
        nodeConfig.prefixIcon!,
        height: 24,
        colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
      );
      return svg;
    }
    return Container();
  }
}
