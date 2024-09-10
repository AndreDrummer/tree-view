import 'package:flutter/material.dart';

class CustomScrollBar extends StatefulWidget {
  const CustomScrollBar({
    super.key,
    required this.fixedWidget,
    required this.scrollables,
  });

  final List<Widget> scrollables;
  final Widget fixedWidget;

  @override
  State<CustomScrollBar> createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
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
