import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;

  ReadMoreText({@required this.text});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : 3,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Read More' : 'Read Less',
            style: TextStyle(
              color: Color(0xffFF4181),
            ),
          ),
        ),
      ],
    );
  }
}
