import 'package:flutter/material.dart';

class MPButtonIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final bool withBackgroundColor;
  final double size;
  final Function onTap;

  const MPButtonIcon({
    @required this.iconData,
    @required this.onTap,
    this.iconColor,
    this.withBackgroundColor = false,
    this.size = 40,
  })  : assert(iconData != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: withBackgroundColor
          ? Theme.of(context).primaryColorLight.withOpacity(.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(size/2),
      child: InkWell(
        borderRadius: BorderRadius.circular(size/2),
        child: Container(
          width: size,
          height: size,
          child: Icon(
            iconData,
            color: iconColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
