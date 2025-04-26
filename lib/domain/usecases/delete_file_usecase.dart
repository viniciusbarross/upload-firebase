import '../repositories/storage_repository.dart';

class DeleteFileUsecase {
  final StorageRepository repository;

  DeleteFileUsecase(this.repository);

  Future<void> call(String name) {
    return repository.deleteFile(name);
  }
}
