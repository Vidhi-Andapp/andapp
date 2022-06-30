import 'package:flutter/material.dart';
import 'app_theme.dart';

class PinkBorderButton extends StatefulWidget {
  const PinkBorderButton({
    Key? key,
    required this.isEnabled,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  final String content;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  _PinkBorderButtonState createState() => _PinkBorderButtonState();
}

class _PinkBorderButtonState extends State<PinkBorderButton> {
  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return OutlinedButton(
        onPressed: widget.onPressed,

        style: OutlinedButton.styleFrom(
            side: BorderSide(color: _appTheme.primaryColor,width: 1),
            shape: RoundedRectangleBorder(borderRadius : BorderRadius.circular(30))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text((widget.content),textAlign: TextAlign.center,style: TextStyle(color: _appTheme.primaryColor),),
        )
    );
  }
}