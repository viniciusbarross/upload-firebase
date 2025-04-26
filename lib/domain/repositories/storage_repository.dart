import '../entities/file_entity.dart';

abstract class StorageRepository {
  Future<void> uploadFile(String path);
  Future<List<FileEntity>> listFiles();

  Future<void> deleteFile(String name);
  Future<String> getDownloadUrl(String path);
}
