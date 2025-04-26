import '../repositories/storage_repository.dart';

class UploadFileUsecase {
  final StorageRepository repository;

  UploadFileUsecase(this.repository);

  Future<void> call(String path) {
    return repository.uploadFile(path);
  }
}