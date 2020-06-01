import 'dart:isolate';

import 'package:image/image.dart';

class ResizeFunctionParameter {
  SendPort sendPort;

  Image src;
  int width;
  int height;
  Interpolation interpolation;

  ResizeFunctionParameter(
    this.sendPort,
    this.src, {
    this.width,
    this.height,
    this.interpolation = Interpolation.nearest,
  });
}
