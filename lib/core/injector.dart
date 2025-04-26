import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:upload_app/domain/usecases/delete_file_usecase.dart';
import 'package:upload_app/domain/usecases/get_download_url_usecase.dart';
import '../infra/datasources/auth_datasource.dart';
import '../infra/datasources/storage_datasource.dart';
import '../infra/repositories/auth_repository_impl.dart';
import '../infra/repositories/storage_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/storage_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../domain/usecases/upload_file_usecase.dart';
import '../domain/usecases/list_files_usecase.dart';
import '../presentation/cubits/auth_cubit.dart';
import '../presentation/cubits/file_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);

  getIt.registerLazySingleton<AuthDatasource>(() => AuthDatasource(getIt()));
  getIt.registerLazySingleton<StorageDatasource>(
      () => StorageDatasource(getIt()));

  getIt
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton(() => RegisterUsecase(getIt()));
  getIt.registerLazySingleton(() => UploadFileUsecase(getIt()));
  getIt.registerLazySingleton(() => ListFilesUsecase(getIt()));
  getIt.registerLazySingleton(() => GetDownloadUrlUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteFileUsecase(getIt()));

  getIt.registerFactory(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory(() => FileCubit(getIt(), getIt(), getIt(), getIt()));
}
