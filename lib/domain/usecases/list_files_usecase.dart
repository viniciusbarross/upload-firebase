import '../repositories/storage_repository.dart';
import '../entities/file_entity.dart';

class ListFilesUsecase {
  final StorageRepository repository;

  ListFilesUsecase(this.repository);

  Future<List<FileEntity>> call() {
    return repository.listFiles();
  }
}