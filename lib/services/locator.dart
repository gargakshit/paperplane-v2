import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'accounts/accounts_service.dart';
import 'accounts/accounts_service_http.dart';
import 'file_encryption/file_encryption_service.dart';
import 'file_encryption/file_encryption_service_aescrypt.dart';
import 'media/media_service.dart';
import 'media/media_service_http.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingleton<Dio>(Dio());

  locator.registerLazySingleton<AccountsService>(() => AccountsServiceHttp());
  locator.registerLazySingleton<FileEncryptionService>(
    () => FileEncryptionServiceAesCrypt(),
  );
  locator.registerLazySingleton<MediaService>(() => MediaServiceHttp());
}
