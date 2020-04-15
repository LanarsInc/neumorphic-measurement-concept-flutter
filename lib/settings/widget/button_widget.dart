import 'package:flutter/material.dart';

class _IconButton extends Button {
  _IconButton({Key key, IconData icon, VoidCallback onTap})
      : super(
          key: key,
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          onTap: onTap,
        );
}

class _TextButton extends Button {
  final String labelText;

  _TextButton({Key key, VoidCallback onTap, this.labelText})
      : super(
          key: key,
          width: double.infinity,
          height: 64,
          radius: 32,
          blurRadius: 16,
          child: Center(
            child: Text(
              labelText,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: super.build(context),
    );
  }
}

abstract class Button extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final double blurRadius;
  final Widget child;
  final VoidCallback onTap;

  Button({
    Key key,
    @required this.width,
    @required this.height,
    this.radius = 8,
    this.blurRadius = 8,
    @required this.child,
    this.onTap,
  }) : super(key: key);

  factory Button.icon({
    Key key,
    IconData icon,
    VoidCallback onTap,
  }) = _IconButton;

  factory Button.text({
    Key key,
    String labelText,
    VoidCallback onTap,
  }) = _TextButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              blurRadius: blurRadius,
              offset: Offset(4, 4),
              color: Color.lerp(theme.accentColor, Colors.white, .4),
            ),
          ],
        ),
        child: child,
      ),
      onTap: onTap,
    );
  }
}
