import 'package:flutter/material.dart';

class GridViewContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? bgColor;
  final double? width;
  final double? height;

  const GridViewContainer({
    super.key,
    required this.child,
    this.padding,
    this.bgColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.cyan,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: child,
    );
  }
}
