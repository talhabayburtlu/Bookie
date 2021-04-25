import 'package:flutter/material.dart';

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  final bool busy;
  final Widget title;
  final Function onPressed;
  final bool enabled;
  final BoxDecoration decoration;
  final double height;
  const BusyButton(
      {@required this.title,
      this.busy = false,
      @required this.onPressed,
      this.enabled = true,
      this.decoration,
      this.height = 40});

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: GestureDetector(
        onTap: widget.busy ? null : widget.onPressed,
        child: InkWell(
          child: AnimatedContainer(
            height: widget.busy ? widget.height : null,
            width: widget.busy ? widget.height : null,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: widget.busy ? 5 : 15,
                vertical: widget.busy ? 5 : 5),
            decoration: widget.decoration,
            child: !widget.busy
                ? widget.title
                : CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
        ),
      ),
    );
  }
}
