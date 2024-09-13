import 'package:flutter/material.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';

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
        cursorColor: AppTheme.light,
        style: const TextStyle(color: AppTheme.light, fontSize: 14),
        onSubmitted: widget.search,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8.0),
          hintStyle: const TextStyle(color: AppTheme.light2),
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search, color: AppTheme.light2),
          suffixIcon: Visibility(
            visible: _textEditingController.text.isNotEmpty,
            child: IconButton(
              onPressed: clear,
              icon: const Icon(Icons.close, color: AppTheme.light2),
            ),
          ),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder().copyWith(
            borderSide: const BorderSide(
              color: AppTheme.light,
            ),
          ),
          border: _inputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.light2,
      ),
    );
  }
}
