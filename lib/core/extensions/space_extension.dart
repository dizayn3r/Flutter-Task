import 'package:flutter/cupertino.dart';

extension SpacingExtension on Widget {
  /// Top Spacing
  Widget topSpacing(double space) {
    return Column(
      children: [
        SizedBox(height: space),
        this,
      ],
    );
  }

  /// Bottom Spacing
  Widget bottomSpacing(double space) {
    return Column(
      children: [
        this,
        SizedBox(height: space),
      ],
    );
  }

  /// Left Spacing
  Widget leftSpacing(double space) {
    return Column(
      children: [
        this,
        SizedBox(width: space),
      ],
    );
  }

  /// Right Spacing
  Widget rightSpacing(double space) {
    return Column(
      children: [
        this,
        SizedBox(width: space),
      ],
    );
  }
}
