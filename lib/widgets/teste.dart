import 'package:flutter/material.dart';

class BidirectionalCarousel extends StatefulWidget {
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final double viewHeight;
  final double viewWidth;
  final Widget child;

  const BidirectionalCarousel({
    this.allowHorizontalScrool = true,
    this.allowVerticalScrool = true,
    required this.viewHeight,
    required this.viewWidth,
    required this.child,
    super.key,
  });

  @override
  State<BidirectionalCarousel> createState() => _BidirectionalCarouselState();
}

class _BidirectionalCarouselState extends State<BidirectionalCarousel> {
  // Scroll controllers for both directions
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();

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
