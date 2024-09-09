import 'package:tree_view/shared/simple_tree/widgets/custom_scroll_with_fixed_widget.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/shared/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/shared/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/shared/simple_tree/models/parent.dart';
import 'package:tree_view/shared/simple_tree/widgets/tree.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TreeWidget<T> extends StatefulWidget {
  const TreeWidget({
    super.key,
    this.alwaysScrollToTheEndOfData = true,
    required this.breadCrumbLinesColor,
    required this.elementsColor,
    required this.nodeConfig,
    required this.dataList,
    this.backgroundColor,
    this.backToTopButton,
  });

  final List<Parent> dataList;

  final bool alwaysScrollToTheEndOfData;
  final Color breadCrumbLinesColor;
  final Widget? backToTopButton;
  final Color? backgroundColor;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeConfig;

  @override
  State<TreeWidget<T>> createState() => _TreeWidgetState<T>();
}

class _TreeWidgetState<T> extends State<TreeWidget<T>> {
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;
  late final TreeManager _treeInstance;

  double backToTopButtonOpacity = 0;

  Widget backToTopWidget() {
    if (widget.backToTopButton == null) {
      return FloatingActionButton(
        onPressed: scrollToTheBeginningOfData,
        child: const Icon(Icons.arrow_upward_rounded),
      );
    } else {
      return widget.backToTopButton!;
    }
  }

  @override
  void initState() {
    _treeInstance = TreeManager.instance(widget.dataList);
    horizontalScrollController = ScrollController();
    verticalScrollController = ScrollController();

    verticalScrollController.addListener(() {
      setState(() {
        bool logic = verticalScrollController.offset > 0;

        backToTopButtonOpacity = logic ? 1.0 : 0.0;
      });
    });

    super.initState();
  }

  NodeRowConfig nodeConfig(data) {
    return widget.nodeConfig(data as T);
  }

  void onNodeToggled(node) {
    setState(() {
      _treeInstance.toogleNodeView(node);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, _) {
      final sizeOf = MediaQuery.sizeOf(context);

      return SafeArea(
        child: Scaffold(
          backgroundColor: widget.backgroundColor,
          body: CustomScrollWithFixedWidget(
            scrollToTheEndOfData: widget.alwaysScrollToTheEndOfData,
            scrollController: verticalScrollController,
            jumpToWhenScrolling: sizeOf.height,
            fixedWidget: const CustomAppBar(),
            scrollables: [
              Tree(
                _treeInstance.treeRoot,
                breadCrumbLinesColor: widget.breadCrumbLinesColor,
                horizontalController: horizontalScrollController,
                elementsColor: widget.elementsColor,
                toggleNodeView: onNodeToggled,
                nodeRowConfig: nodeConfig,
              ),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            duration: Durations.medium2,
            opacity: backToTopButtonOpacity,
            child: backToTopWidget(),
          ),
        ),
      );
    });
  }

  void scrollToTheEndOfData(
    bool isToScroll, {
    double horizontalJumpTo = 0,
    double verticalJumpTo = 0,
    int rootHeight = 0,
  }) {
    if (isToScroll) {
      verticalScrollController.animateTo(
        duration: const Duration(seconds: 5),
        verticalJumpTo * rootHeight,
        curve: Curves.easeIn,
      );
      horizontalScrollController.animateTo(
        horizontalJumpTo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    }
  }

  void scrollToTheBeginningOfData() {
    verticalScrollController.animateTo(
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeIn,
      0,
    );
    horizontalScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeIn,
    );
  }

  double calculatesHorizontalScrolling(int treeHeight) {
    return (treeHeight * treeHeight).toDouble();
  }

  void scrollWhenFilter(bool isToScroll, double verticalJumpTo) {
    final horizontalJumpTo = calculatesHorizontalScrolling(
      _treeInstance.treeRoot.getHeight,
    );

    scrollToTheEndOfData(
      rootHeight: _treeInstance.treeRoot.getHeight,
      horizontalJumpTo: horizontalJumpTo,
      verticalJumpTo: verticalJumpTo,
      isToScroll,
    );
  }
}
