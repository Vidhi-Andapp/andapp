import 'package:flutter/widgets.dart';

class MessageBorder extends ShapeBorder {
  final bool usePadding;

  const MessageBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.fromLTRB(4,4,4,16);

  @override
  //Path getInnerPath(Rect rect, {TextDirection? textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 10));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, 15)
      ..relativeLineTo(10, -15)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }
}