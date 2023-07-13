import 'package:flutter/material.dart';

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({
    Key key,
    @required this.icon,
    @required this.title,
    this.color = Colors.deepPurple,
    this.iconColor = Colors.deepPurple,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: color),
        ),
      ],
    );
  }
}
