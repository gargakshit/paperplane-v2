import 'package:blurhash_dart/blurhash_dart.dart';

import '../models/services/blurhash_function.dart';

void generateBlurHash(BlurHashFunctionParameter parameter) {
  String blurHash = encodeBlurHash(
    parameter.data,
    parameter.width,
    parameter.height,
    numCompX: parameter.numCompX,
    numpCompY: parameter.numCompY,
  );

  parameter.sendPort.send(blurHash);
}
