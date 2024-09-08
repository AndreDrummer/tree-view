import 'package:flutter/material.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
    required this.color,
    this.hintTextColor,
    this.hintText,
    this.search,
  });

  final Function(String)? search;
  final Color? hintTextColor;
  final String? hintText;
  final Color color;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  void clear() {
    setState(() {
      _textEditingController.clear();
    });
    widget.search?.call("");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textEditingController,
        onChanged: (value) {
          setState(() {
            _textEditingController.text = value;
          });

          widget.search?.call(_textEditingController.text);
        },
        style: TextStyle(color: widget.color),
        onSubmitted: widget.search,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: widget.hintTextColor),
          hintText: widget.hintText,
          prefixIcon: Visibility(
            visible: _textEditingController.text.isEmpty,
            child: const Icon(Icons.search),
          ),
          suffixIcon: Visibility(
            visible: _textEditingController.text.isNotEmpty,
            child: IconButton(
              onPressed: clear,
              icon: const Icon(Icons.close),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
