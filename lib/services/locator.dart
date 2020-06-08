import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accounts/accounts_service.dart';
import 'accounts/accounts_service_http.dart';
import 'blurhash/blurhash_service.dart';
import 'blurhash/blurhash_service_blurhash.dart';
import 'chat/chat_service.dart';
import 'chat/chat_service_tcp.dart';
import 'file_encryption/file_encryption_service.dart';
import 'file_encryption/file_encryption_service_aescrypt.dart';
import 'key_value/key_value_service.dart';
import 'key_value/key_value_service_sharedprefs.dart';
import 'media/media_service.dart';
import 'media/media_service_http.dart';
import 'nacl/nacl_service.dart';
import 'nacl/nacl_service_pinenacl.dart';
import '../models/services/chat_state.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  locator.registerSingleton<ChatState>(ChatState());

  locator.registerLazySingleton<AccountsService>(
    () => AccountsServiceHttp(),
  );
  locator.registerLazySingleton<BlurHashService>(
    () => BlurHashServiceBlurHash(),
  );
  locator.registerLazySingleton<ChatService>(() => ChatServiceTcp());
  locator.registerLazySingleton<FileEncryptionService>(
    () => FileEncryptionServiceAesCrypt(),
  );
  locator.registerLazySingleton<KeyValueService>(
    () => KeyValueServiceSharedPrefs(),
  );
  locator.registerLazySingleton<MediaService>(
    () => MediaServiceHttp(),
  );
  locator.registerLazySingleton<NaClService>(
    () => NaClServicePineNaCl(),
  );
}
