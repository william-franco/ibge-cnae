import 'dart:async';

import 'package:material_ui/material_ui.dart';

class CnaeSearchFieldWidget extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onCodeSubmit;
  final String? hintText;

  const CnaeSearchFieldWidget({
    super.key,
    required this.onQueryChanged,
    required this.onCodeSubmit,
    this.hintText,
  });

  @override
  State<CnaeSearchFieldWidget> createState() => _CnaeSearchFieldWidgetState();
}

class _CnaeSearchFieldWidgetState extends State<CnaeSearchFieldWidget> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  static final _codePattern = RegExp(r'^\d{2,7}$');

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      widget.onQueryChanged(value);
    });
  }

  void _submit(String value) {
    final trimmed = value.trim();
    if (_codePattern.hasMatch(trimmed)) {
      widget.onCodeSubmit(trimmed);
    }
  }

  void _clear() {
    _controller.clear();
    setState(() {});
    widget.onQueryChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SearchBar(
        controller: _controller,
        hintText: widget.hintText ?? 'Código ou descrição neste nível',
        leading: const Icon(Icons.search),
        trailing: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clear,
            ),
        ],
        onChanged: (value) {
          setState(() {});
          _onChanged(value);
        },
        onSubmitted: _submit,
      ),
    );
  }
}