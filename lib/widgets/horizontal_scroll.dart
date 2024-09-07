import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final double viewHeight;
  final double viewWidth;
  final Widget child;

  const HorizontalScroll({
    this.allowHorizontalScrool = true,
    this.allowVerticalScrool = true,
    required this.viewHeight,
    required this.viewWidth,
    required this.child,
    super.key,
  });

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  final ScrollController horizontalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
