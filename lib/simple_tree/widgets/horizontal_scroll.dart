import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  final ScrollController horizontalController;
  final bool allowHorizontalScrool;
  final bool scrollToTheEndOfData;
  final bool allowVerticalScrool;
  final double viewHeight;
  final double viewWidth;
  final double jumpTo;
  final Widget child;

  const HorizontalScroll({
    required this.horizontalController,
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
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  late ScrollController horizontalController;

  @override
  void initState() {
    horizontalController = widget.horizontalController;

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            width: widget.viewWidth,
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
        ],
      ),
    );
  }
}
