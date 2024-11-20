import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double elevation;
  final Color? backgroundColor;
  final Builder? leading;
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.elevation = 0,
    this.backgroundColor,
    this.leading,
    required this.title,
    this.titleStyle,
    this.actions,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: widget.elevation != 0 ? widget.elevation : 0,
      backgroundColor: widget.backgroundColor ?? Colors.grey[300],
      scrolledUnderElevation: 0,
      leading: widget.leading,
      title: Text(
        widget.title,
        style: widget.titleStyle ??
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              letterSpacing: 0.5,
            ),
      ),
      actions: widget.actions,
    );
  }
}
