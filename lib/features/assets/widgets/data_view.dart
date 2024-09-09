import 'package:tree_view/core/widgets/custom_scroll_with_fixed_widget.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/shared/simple_tree/models/parent.dart';
import 'package:tree_view/shared/simple_tree/tree_manager.dart';
import 'package:tree_view/shared/simple_tree/widgets/tree.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DataView<T> extends StatefulWidget {
  const DataView({
    super.key,
    required this.breadCrumbLinesColor,
    this.scrollToTheEndOfData = true,
    required this.elementsColor,
    required this.nodeRowTitle,
    required this.dataList,
    this.backgroundColor,
    this.backToTopButton,
  });

  final String Function(T data) nodeRowTitle;
  final Color breadCrumbLinesColor;
  final bool scrollToTheEndOfData;
  final Widget? backToTopButton;
  final Color? backgroundColor;
  final List<Parent> dataList;
  final Color elementsColor;

  @override
  State<DataView<T>> createState() => _DataViewState<T>();
}

class _DataViewState<T> extends State<DataView<T>> {
  late final TreeManager _treeInstance;
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;
  double backToTopButtonOpacity = 0;

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

  void lepo(bool isToScroll, double verticalJumpTo) {
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

  Widget backToTopWidget() {
    return widget.backToTopButton ??
        FloatingActionButton(
          onPressed: scrollToTheBeginningOfData,
          child: const Icon(Icons.arrow_upward_rounded),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, _) {
      final sizeOf = MediaQuery.sizeOf(context);

      return SafeArea(
        child: Scaffold(
          backgroundColor: widget.backgroundColor,
          body: CustomScrollWithFixedWidget(
            scrollToTheEndOfData: widget.scrollToTheEndOfData,
            scrollController: verticalScrollController,
            jumpToWhenScrolling: sizeOf.height,
            fixedWidget: const CustomAppBar(),
            scrollables: [
              Tree(
                nodeRowTitle: (data) {
                  return widget.nodeRowTitle(data as T);
                },
                _treeInstance.treeRoot,
                toggleNodeView: (node) {
                  setState(() {
                    _treeInstance.toogleNodeView(node);
                  });
                },
                breadCrumbLinesColor: widget.breadCrumbLinesColor,
                horizontalController: horizontalScrollController,
                elementsColor: widget.elementsColor,
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
}
