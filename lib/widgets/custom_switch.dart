import 'package:flutter/cupertino.dart';
import 'package:vendeaze/core/app_export.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    Key? key,
    required this.onChange,
    this.alignment,
    required this.value, // Mark as required
    this.width,
    this.height,
    this.margin,
  }) : super(
          key: key,
        );

  final Alignment? alignment;
  final bool value; // Mark as final

  final Function(bool) onChange;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: alignment != null
          ? Align(
              alignment: alignment ?? Alignment.center,
              child: switchWidget,
            )
          : switchWidget,
    );
  }

  Widget get switchWidget => CupertinoSwitch(
        value: value,
        trackColor: theme.colorScheme.onErrorContainer,
        thumbColor: value
            ? theme.colorScheme.primary
            : theme.colorScheme.primary,
        activeColor: theme.colorScheme.onErrorContainer,
        onChanged: (value) {
          onChange(value);
        },
      );
}
