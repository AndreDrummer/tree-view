import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:tree_view/core/widgets/custom_scroll_with_fixed_widget.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/features/assets/widgets/tree_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;

  @override
  void initState() {
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
    super.didChangeDependencies();
  }

  double calculatesHorizontalScrolling(int treeHeight) {
    return (treeHeight * treeHeight).toDouble();
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
                        controller.root.getHeight,
                      );

                      scrollToTheEndOfData(
                        rootHeight: controller.root.getHeight,
                        horizontalJumpTo: horizontalJumpTo,
                        verticalJumpTo: sizeOf.height,
                        isToScroll,
                      );
                    },
                  ),
                  TreeView(
                    controller.root,
                    darkModeIsON: darkModeIsON,
                    toggleNodeView: (node) {
                      controller.toogleNodeView(node);
                    },
                    horizontalController: horizontalScrollController,
                  ),
                ],
              ),
              floatingActionButton: AnimatedOpacity(
                duration: Durations.extralong4,
                opacity:
                    controller.isFilteringByAny && controller.hasData ? 1 : 0,
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
