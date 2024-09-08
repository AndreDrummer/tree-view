import 'package:flutter/material.dart';

class CustomScrollWithFixedWidget extends StatefulWidget {
  const CustomScrollWithFixedWidget({
    super.key,
    this.scrollToTheEndOfData = false,
    required this.scrollController,
    this.jumpToWhenScrolling = 0,
    required this.fixedWidget,
    required this.scrollables,
  });

  final ScrollController scrollController;
  final double jumpToWhenScrolling;
  final bool scrollToTheEndOfData;
  final List<Widget> scrollables;
  final Widget fixedWidget;

  @override
  State<CustomScrollWithFixedWidget> createState() =>
      _CustomScrollWithFixedWidgetState();
}

class _CustomScrollWithFixedWidgetState
    extends State<CustomScrollWithFixedWidget> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;

    if (widget.scrollToTheEndOfData) {
      Future.delayed(
        const Duration(seconds: 1),
        () => scrollController.animateTo(
          duration: const Duration(seconds: 1),
          widget.jumpToWhenScrolling,
          curve: Curves.easeIn,
        ),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        PinnedHeaderSliver(child: widget.fixedWidget),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return widget.scrollables.elementAt(index);
            },
            childCount: widget.scrollables.length,
          ),
        ),
      ],
    );
  }
}
