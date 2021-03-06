import 'package:flutter/material.dart';

class MPListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool hasTrailing;
  final Function onTap;

  const MPListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.hasTrailing = true,
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
        subtitle: subtitle,
        trailing: hasTrailing
            ? trailing ??
                Container(
                  width: 16,
                  child: Icon(
                    Icons.chevron_right,
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.2),
                  ),
                )
            : null,
        onTap: onTap,
      ),
    );
  }
}
