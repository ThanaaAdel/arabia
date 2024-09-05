import 'package:flutter/material.dart';

class HotRestartController extends StatefulWidget {
  final Widget child;

  const HotRestartController({super.key, required this.child});

  static performHotRestart(BuildContext context) {
    final _HotRestartControllerState? state =
        context.findAncestorStateOfType<_HotRestartControllerState>();
    state?.performHotRestart();
  }

  @override
  _HotRestartControllerState createState() => _HotRestartControllerState();
}

class _HotRestartControllerState extends State<HotRestartController> {
  Key key = UniqueKey();

  void performHotRestart() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
