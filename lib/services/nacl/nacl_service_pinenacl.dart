import 'package:pinenacl/secret.dart';

import 'nacl_service.dart';

class NaClServicePineNaCl extends NaClService {
  @override
  PrivateKey generateKeyPair() {
    return PrivateKey.generate();
  }

  @override
  PrivateKey fromSeed(List<int> seed) {
    return PrivateKey.fromSeed(seed);
  }
}
