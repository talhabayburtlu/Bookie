import 'package:bookie/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget leading;

  const GlobalAppBar({Key key, this.title = "", this.actions, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x59abb4bd), width: 0.5),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x10000000),
                  offset: Offset(0, 5),
                  blurRadius: 25,
                  spreadRadius: 0)
            ],
            color: const Color(0xffffffff)),
        child: AppBar(
          leading: leading,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff4b515c)),
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: darkGrey,
            ),
          ),
          actions: actions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
