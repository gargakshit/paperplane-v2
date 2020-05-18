import 'package:pinenacl/secret.dart';

abstract class NaClService {
  PrivateKey generateKeyPair();
  PrivateKey fromSeed(List<int> seed);
}
