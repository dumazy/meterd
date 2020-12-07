import 'package:app/main.dart';
import 'package:app/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onPressed;

  const BottomBar({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottom_bar_height,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: ClipPath(
                  clipper: _ButtonClipper(),
                  child: Container(
                    height: double.infinity,
                    color: Colors.lightBlue,
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      onPressed: onPressed,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              Spacer(),
              Flexible(
                child: _SettingsButton(),
              ),
            ],
          ),
        ],
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

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: RaisedButton(
          padding: EdgeInsets.all(20.0),
          color: Colors.lightBlue,
          shape: CircleBorder(),
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () => _goToSettings(context),
        ),
      ),
    );
  }

  void _goToSettings(BuildContext context) {
    Navigator.of(context).push(SettingsScreen.route());
  }
}
