import 'package:flutter/material.dart';

class UnFocus extends StatefulWidget {
  const UnFocus({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<UnFocus> createState() => _UnFocusState();
}

class _UnFocusState extends State<UnFocus> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => FocusManager.instance.primaryFocus?.unfocus(), child: widget.child);
  }
}
