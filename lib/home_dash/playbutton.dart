import 'package:flutter/material.dart';
import 'blob.dart';
import 'dart:math' show pi;

import 'dashBoardPage.dart';

class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 100);
  static const _kRotationDuration = Duration(seconds: 3);

  bool isPlaying = true;
  // rotation and scale animations
  AnimationController _rotationController;
  AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 1.35;

  bool get _showWaves => _scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 0.80 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.5) + 0.85;

  @override
  void initState() {
    _rotationController =
    AnimationController(vsync: this, duration: _kRotationDuration)
      ..addListener(() => setState(_updateRotation))
      ..repeat();

    _scaleController =
    AnimationController(vsync: this, duration: _kToggleDuration)
      ..addListener(() => setState(_updateScale));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(color: Color(0xff0092ff), scale: _scale, rotation: _rotation),
            Blob(
                color: Color(0xff4ac7b7),
                scale: _scale,
                rotation: _rotation * 2 - 30),
            Blob(
                color: Color(0xffa4a6f6),
                scale: _scale,
                rotation: _rotation * 3 - 45),
            Blob(
                color: Color(0xffc74aa4),
                scale: _scale,
                rotation: _rotation * 4 - 60),
            Blob(
                color: Color(0xff85e321),
                scale: _scale,
                rotation: _rotation * 5 - 90),
            Blob(
                color: Color(0xfff5d414),
                scale: _scale,
                rotation: _rotation * 6 - 120),
          ],
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 0.01),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$battery %',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
                ),
                Text(
                  'Battery Percentage',
                  style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w900,color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
