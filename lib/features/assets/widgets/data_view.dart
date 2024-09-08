import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/features/assets/widgets/tree_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DataView extends StatefulWidget {
  const DataView({super.key, this.darkModeIsON = true});
  final bool darkModeIsON;

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  void didChangeDependencies() {
    Provider.of<AssetsController>(context, listen: false).searchByText("Bruno");
    // .filterByFemaleGender();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetsController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SearchHeader(darkModeIsON: widget.darkModeIsON),
              TreeView(
                controller.root,
                darkModeIsON: widget.darkModeIsON,
                toggleNodeView: (node) {
                  controller.toogleNodeView(node);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
