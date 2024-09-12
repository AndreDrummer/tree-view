import 'package:flutter/material.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
    required this.initialValue,
    required this.color,
    this.hintTextColor,
    this.hintText,
    this.search,
  });

  final Function(String)? search;
  final Color? hintTextColor;
  final String initialValue;
  final String? hintText;
  final Color color;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initialValue);
    _textEditingController.addListener(() {
      if (_textEditingController.text.isEmpty) {
        FocusScope.of(context).unfocus();
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(InputSearch oldWidget) {
    _textEditingController.text = widget.initialValue;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
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
        cursorColor: Colors.grey,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        onSubmitted: widget.search,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8.0),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: widget.hintText,
          prefixIcon: _textEditingController.text.isEmpty
              ? const Icon(Icons.search, color: Colors.grey)
              : null,
          suffixIcon: Visibility(
            visible: _textEditingController.text.isNotEmpty,
            child: IconButton(
              onPressed: clear,
              icon: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(),
          border: _inputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    );
  }
}
