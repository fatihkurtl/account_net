import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;

  const SettingsItem({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
    this.icon,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.grey[800],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) trailing!,
          if (icon != null) ...[
            if (trailing != null) const SizedBox(width: 8),
            Icon(
              icon,
              color: iconColor ?? Colors.grey[800],
            ),
          ],
        ],
      ),
      onTap: onTap,
      tileColor: Colors.grey[350],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
