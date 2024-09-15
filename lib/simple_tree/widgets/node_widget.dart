import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/builder.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:get/get.dart' hide Node;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NodeWidget<T> extends StatelessWidget {
  const NodeWidget(
    this.node, {
    required this.showCustomizationForRoot,
    required this.breadCrumbLineColor,
    required this.elementsColor,
    required this.nodeRowConfig,
    required this.nodeRootId,
    required this.toggleNode,
    super.key,
  });

  final NodeRowConfig Function(T) nodeRowConfig;
  final Function(Node<NodeData<T>>) toggleNode;
  final Node<NodeData<T>> node;

  final bool showCustomizationForRoot;
  final Color breadCrumbLineColor;
  final Color elementsColor;
  final int nodeRootId;

  bool showCustomization() {
    if (node.id == nodeRootId) {
      return showCustomizationForRoot;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    NodeRowConfig? nodeConfig;

    if (node.value?.data != null) {
      nodeConfig = nodeRowConfig(node.value!.data as T);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: node.getHeightFromNodeToRoot * 20),
              width: node.getHeightFromNodeToRoot > 0 ? 1 : 0,
              color: breadCrumbLineColor,
              height: 48,
            ),
            Visibility(
              visible: node.hasChildren,
              replacement: Container(
                color: breadCrumbLineColor,
                width: 48,
                height: 1,
              ),
              child: IconButton(
                onPressed: () => toggleNode(node),
                icon: Icon(
                  !node.hasChildren || !node.expanded
                      ? Icons.keyboard_arrow_right_outlined
                      : Icons.keyboard_arrow_down,
                  color: elementsColor,
                ),
              ),
            ),
            _prefixIcon(context, nodeConfig, showCustomizationForRoot),
            TextButton(
              onPressed: () => toggleNode(node),
              child: Text(
                "${nodeConfig?.title}",
                style: TextStyle(color: elementsColor, fontSize: 18),
              ),
            ),
            _suffixIcon(context, nodeConfig, showCustomizationForRoot),
          ],
        ),
        Visibility(
          visible: node.expanded,
          child: SizedBox(
            width: double.maxFinite,
            height: node.children!.length * 49,
            child: ListView.builder(
              itemCount: node.children!.length,
              itemBuilder: (context, index) {
                final nodeChild = node.children![index];

                return builder(
                  nodeChild,
                  showCustomizationForRoot: showCustomizationForRoot,
                  breadCrumbLinesColor: breadCrumbLineColor,
                  nodeRowConfig: nodeRowConfig,
                  elementsColor: elementsColor,
                  toggleNode: toggleNode,
                  nodeRootId: nodeRootId,
                );
              },
            ),
          ),
        ),
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
