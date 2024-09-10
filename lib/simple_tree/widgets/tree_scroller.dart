import 'package:flutter/material.dart';

class TreeScroller extends StatefulWidget {
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final bool allowHorizontalScrool;
  final bool alwaysScrollToTheEndOfTree;
  final bool allowVerticalScrool;
  final bool showBackTopButton;
  final int nodeDecendants;
  final double viewHeight;
  final double viewWidth;
  final int nodeHeight;
  final Widget child;

  const TreeScroller({
    this.alwaysScrollToTheEndOfTree = true,
    required this.horizontalController,
    this.allowHorizontalScrool = true,
    required this.verticalController,
    this.allowVerticalScrool = true,
    this.showBackTopButton = true,
    required this.nodeDecendants,
    required this.nodeHeight,
    required this.viewHeight,
    required this.viewWidth,
    required this.child,
    super.key,
  });

  @override
  State<TreeScroller> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<TreeScroller> {
  late ScrollController horizontalController;
  late ScrollController verticalController;
  double backToTopButtonOpacity = 0.0;

  @override
  void initState() {
    horizontalController = widget.horizontalController;
    verticalController = widget.verticalController;

    super.initState();
  }

  void scrollToTheEndOfTree() {
    if (widget.alwaysScrollToTheEndOfTree) {
      verticalController.animateTo(
        verticalController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    }
  }

  void scrollToTheBeginningOfData() {
    verticalController.animateTo(
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      0,
    );
    horizontalController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  void didChangeDependencies() {
    verticalController.addListener(() {
      setState(() {
        backToTopButtonOpacity = verticalController.offset > 0 ? 1.0 : 0.0;
      });
    });

    Future.delayed(const Duration(seconds: 1), scrollToTheEndOfTree);

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TreeScroller oldWidget) {
    scrollToTheEndOfTree();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VerticalScroller(
          allowScroll: widget.allowVerticalScrool,
          controller: verticalController,
          height: widget.viewHeight,
          horizontalController: HorizontalScroller(
            allowScroll: widget.allowHorizontalScrool,
            controller: horizontalController,
            width: widget.viewWidth,
            child: widget.child,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Visibility(
            visible: (widget.showBackTopButton && widget.allowVerticalScrool),
            child: AnimatedOpacity(
              duration: Durations.extralong4,
              opacity: backToTopButtonOpacity,
              child: FloatingActionButton(
                onPressed: scrollToTheBeginningOfData,
                child: const Icon(Icons.arrow_upward_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VerticalScroller extends StatelessWidget {
  const VerticalScroller({
    super.key,
    required this.horizontalController,
    required this.controller,
    required this.allowScroll,
    required this.height,
  });

  final ScrollController controller;
  final Widget horizontalController;
  final bool allowScroll;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.vertical,
              physics:
                  allowScroll ? null : const NeverScrollableScrollPhysics(),
              child: horizontalController,
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalScroller extends StatelessWidget {
  const HorizontalScroller({
    super.key,
    required this.controller,
    required this.allowScroll,
    required this.width,
    required this.child,
  });

  final ScrollController controller;
  final bool allowScroll;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics:
                  allowScroll ? null : const NeverScrollableScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
