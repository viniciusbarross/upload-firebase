import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/storage_repository.dart';
import '../datasources/storage_datasource.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageDatasource datasource;

  StorageRepositoryImpl(this.datasource);

  @override
  Future<void> uploadFile(String path) {
    return datasource.uploadFile(path);
  }

  @override
  Future<List<FileEntity>> listFiles() async {
    final list = await datasource.listFiles();
    return list
        .map((e) => FileEntity(name: e['name']!, url: e['url']!))
        .toList();
  }

  @override
  Future<String> getDownloadUrl(String path) {
    return datasource.getDownloadUrl(path);
  }

  @override
  Future<void> deleteFile(String name) {
    return datasource.deleteFile(name);
  }
}
