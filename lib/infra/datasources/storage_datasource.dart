import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageDatasource {
  final FirebaseStorage storage;

  StorageDatasource(this.storage);

  Future<void> uploadFile(String path) async {
    final base = path.split('/').last.split('.').first;
    final ext = path.split('.').last;
    String filename = "$base.$ext";
    int i = 1;

    final refs = await storage.ref().listAll();
    final existingNames = refs.items.map((e) => e.name).toList();

    while (existingNames.contains(filename)) {
      filename = "${base}_$i.$ext";
      i++;
    }

    await storage.ref(filename).putFile(File(path));
  }

  Future<List<Map<String, String>>> listFiles() async {
    final result = await storage.ref().listAll();
    final urls = await Future.wait(result.items.map((ref) async {
      final url = await ref.getDownloadURL();
      return {'name': ref.name, 'url': url};
    }));
    return urls;
  }

  Future<String> getDownloadUrl(String path) {
    return storage.ref(path).getDownloadURL();
  }

  Future<void> deleteFile(String path) async {
    await storage.ref(path).delete();
  }
}
