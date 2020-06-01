import 'package:image/image.dart';

import '../models/services/resize_function.dart';

void resizeImage(ResizeFunctionParameter params) {
  Image resizedImage = copyResize(
    params.src,
    width: params.width,
    height: params.height,
    interpolation: params.interpolation,
  );

  params.sendPort.send(resizedImage);
}
