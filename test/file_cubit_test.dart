import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:upload_app/domain/usecases/delete_file_usecase.dart';
import 'package:upload_app/domain/usecases/upload_file_usecase.dart';
import 'package:upload_app/domain/usecases/list_files_usecase.dart';
import 'package:upload_app/domain/usecases/get_download_url_usecase.dart';
import 'package:upload_app/presentation/cubits/file_cubit.dart';
import 'package:upload_app/presentation/states/file_state.dart';
import 'package:upload_app/domain/entities/file_entity.dart';

class MockUpload extends Mock implements UploadFileUsecase {
  @override
  Future<void> call(String path, [String? name]) async {}
}

class MockList extends Mock implements ListFilesUsecase {
  @override
  Future<List<FileEntity>> call() async =>
      [FileEntity(name: 'test.txt', url: 'url')];
}

class MockDownload extends Mock implements GetDownloadUrlUseCase {
  @override
  Future<String> call(String path) async => 'http://url';
}

class MockDelete extends Mock implements DeleteFileUsecase {
  @override
  Future<void> call(String path) async => '';
}

void main() {
  late MockUpload upload;
  late MockList list;
  late MockDownload download;
  late MockDelete delete;
  late FileCubit cubit;

  setUp(() {
    upload = MockUpload();
    list = MockList();
    download = MockDownload();
    delete = MockDelete();
    cubit = FileCubit(upload, list, download, delete);
  });

  test('uploadFile emits FileUploaded', () async {
    await cubit.uploadFile('some/path.txt');
    expect(cubit.state, isA<FileUploaded>());
  });

  test('getDownloadUrl returns string', () async {
    final url = await cubit.getDownloadUrl('some/path.txt');
    expect(url, isA<String>());
  });
}
