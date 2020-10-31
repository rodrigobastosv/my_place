import 'package:flutter/material.dart';

class MPListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final Function onTap;

  const MPListTile({
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        leading: leading == null
            ? null
            : Container(
                alignment: Alignment.center,
                width: 36,
                child: leading,
              ),
        title: title,
        trailing: trailing ??
            Container(
              width: 16,
              child: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.2),
              ),
            ),
        onTap: onTap,
      ),
    );
  }
}
