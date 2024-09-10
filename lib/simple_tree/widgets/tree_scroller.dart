import 'package:flutter/material.dart';

class TreeScroller extends StatefulWidget {
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final bool allowHorizontalScrool;
  final bool scrollToTheEndOfData;
  final bool allowVerticalScrool;
  final double viewHeight;
  final double viewWidth;
  final double jumpTo;
  final Widget child;

  const TreeScroller({
    required this.horizontalController,
    required this.verticalController,
    this.allowHorizontalScrool = true,
    this.scrollToTheEndOfData = true,
    this.allowVerticalScrool = true,
    required this.viewHeight,
    required this.viewWidth,
    required this.child,
    required this.jumpTo,
    super.key,
  });

  @override
  State<TreeScroller> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<TreeScroller> {
  late ScrollController horizontalController;
  late ScrollController verticalController;

  @override
  void initState() {
    horizontalController = widget.horizontalController;
    verticalController = widget.verticalController;

    if (widget.scrollToTheEndOfData) {
      Future.delayed(
        const Duration(seconds: 1),
        () => horizontalController.animateTo(
          widget.jumpTo,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.viewHeight,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: widget.allowVerticalScrool
                  ? null
                  : const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: widget.viewWidth,
                child: SingleChildScrollView(
                  controller: verticalController,
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: widget.allowHorizontalScrool
                              ? null
                              : const NeverScrollableScrollPhysics(),
                          controller: horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
