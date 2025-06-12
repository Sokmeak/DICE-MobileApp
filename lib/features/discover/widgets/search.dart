import 'package:flutter/material.dart';

class SearchCustom extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const SearchCustom({super.key, this.onChanged, this.hintText});

  @override
  State<SearchCustom> createState() => _SearchCustomState();
}

class _SearchCustomState extends State<SearchCustom> {
  final TextEditingController _controller = TextEditingController();

  void _clearText() {
    _controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      height: size.height * 0.055, // Responsive height
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Search...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'poppins-normal',
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: _clearText,
              child: const Icon(Icons.clear, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
