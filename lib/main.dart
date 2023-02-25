import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// An object that takes a double value from 0.0 to 1.0 with a given
  /// duration.
  late final AnimationController _animationController;

  /// The object that can map the double value of the animation controller.
  /*
  For example,
  0.0 = 0 degree
  0.5 = 180 degree
  1.0 = 360 degree
  * */
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      // Vertical sync.
      // For the refresh rate of the screen.
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // The AnimatedBuilder re-renders the widget.
        child: AnimatedBuilder(
          builder: (context, child) {
            return Transform(
              // Rotate around the Z-axis, that goes into the screen.
              transform: Matrix4.identity()..rotateZ(_animation.value),

              // Imagine this like pinning the widget.
              // Pivot point.
              // You can customize the pivot point using Origin.
              // The Origin must make sense w.r.t to the height and width
              // of the widget.
              alignment: Alignment.center,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(spreadRadius: 4.0, offset: Offset(0, 3)),
                  ],
                ),
              ),
            );
          },
          animation: _animationController,
        ),
      ),
    );
  }
}
