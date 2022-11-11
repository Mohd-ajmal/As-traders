import 'package:flutter/material.dart';

class LoadingAsTraders extends StatefulWidget {
  const LoadingAsTraders({Key? key}) : super(key: key);

  @override
  State<LoadingAsTraders> createState() => _LoadingAsTradersState();
}

late AnimationController _animationController;

class _LoadingAsTradersState extends State<LoadingAsTraders>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      alignment: Alignment.center,
      child: RotationTransition(
        child: Image.asset("assets/images/asTraders.png"),
        turns: _animationController,
      ),
    );
  }
}
