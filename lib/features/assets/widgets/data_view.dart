import 'package:tree_view/core/widgets/custom_scroll_with_fixed_widget.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/shared/simple_tree/models/parent.dart';
import 'package:tree_view/shared/simple_tree/tree_manager.dart';
import 'package:tree_view/shared/simple_tree/widgets/tree.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DataView<T> extends StatefulWidget {
  const DataView({
    super.key,
    required this.nodeRowTitle,
    required this.onItemTap,
    required this.dataList,
  });

  final String Function(T data) nodeRowTitle;
  final Function()? onItemTap;

  final List<Parent> dataList;

  @override
  State<DataView<T>> createState() => _DataViewState<T>();
}

class _DataViewState<T> extends State<DataView<T>> {
  late final TreeManager _treeInstance;
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;

  @override
  void initState() {
    _treeInstance = TreeManager.instance(widget.dataList);
    horizontalScrollController = ScrollController();
    verticalScrollController = ScrollController();
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
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      0,
    );
    horizontalScrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  void didChangeDependencies() {
    // Provider.of<AssetsController>(context, listen: false)
    // .searchByText("Mariah");
    //  // .filterByMaleGender();

    verticalScrollController.addListener(() {
      setState(() {});
    });
    super.didChangeDependencies();
  }

  double calculatesHorizontalScrolling(int treeHeight) {
    return (treeHeight * treeHeight).toDouble();
  }

  double showBackToTopButton(bool isFilteringAndHasData) {
    final bool logic =
        isFilteringAndHasData && verticalScrollController.offset > 0;

    return (logic ? 1 : 0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, _) {
      final bool darkModeIsON = homeController.isDarkModeON;
      final backgroundColor = darkModeIsON ? Colors.black : Colors.white;
      final sizeOf = MediaQuery.sizeOf(context);

      return Consumer<AssetsController>(
        builder: (context, controller, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: CustomScrollWithFixedWidget(
                scrollToTheEndOfData: controller.scrollToTheEndOfData,
                jumpToWhenScrolling: sizeOf.height,
                scrollController: verticalScrollController,
                fixedWidget: const CustomAppBar(),
                scrollables: [
                  SearchHeader(
                    darkModeIsON: darkModeIsON,
                    scrollFunction: (isToScroll) {
                      final horizontalJumpTo = calculatesHorizontalScrolling(
                        _treeInstance.treeRoot.getHeight,
                      );

                      scrollToTheEndOfData(
                        rootHeight: _treeInstance.treeRoot.getHeight,
                        horizontalJumpTo: horizontalJumpTo,
                        verticalJumpTo: sizeOf.height,
                        isToScroll,
                      );
                    },
                  ),
                  Tree(
                    darkModeIsON: darkModeIsON,
                    nodeRowTitle: (data) {
                      return widget.nodeRowTitle(data as T);
                    },
                    _treeInstance.treeRoot,
                    toggleNodeView: (node) {
                      setState(() {
                        _treeInstance.toogleNodeView(node);
                      });
                    },
                    horizontalController: horizontalScrollController,
                  ),
                ],
              ),
              floatingActionButton: AnimatedOpacity(
                duration: Durations.extralong4,
                opacity: showBackToTopButton(controller.isFilteringByAny),
                child: FloatingActionButton(
                  onPressed: scrollToTheBeginningOfData,
                  child: const Icon(Icons.arrow_upward_rounded),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
