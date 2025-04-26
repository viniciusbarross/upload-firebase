import '../repositories/storage_repository.dart';

class GetDownloadUrlUseCase {
  final StorageRepository repo;
  GetDownloadUrlUseCase(this.repo);

  Future<String> call(String path) {
    return repo.getDownloadUrl(path);
  }
}
