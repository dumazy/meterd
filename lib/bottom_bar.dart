import 'package:app/main.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onPressed;

  const BottomBar({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottom_bar_height,
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: ClipPath(
        clipper: _ButtonClipper(),
        child: Container(
          width: double.infinity,
          color: Colors.lightBlue,
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Colors.blue,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();

    path.moveTo(0, height);
    path.cubicTo(width / 4, height, width / 4, 0, width / 2, 0);
    path.cubicTo(width * 3 / 4, 0, width * 3 / 4, height, width, height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
