import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_app/domain/usecases/delete_file_usecase.dart';
import 'package:upload_app/domain/usecases/get_download_url_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';
import '../../domain/usecases/list_files_usecase.dart';
import '../../domain/entities/file_entity.dart';
import '../states/file_state.dart';

class FileCubit extends Cubit<FileState> {
  final UploadFileUsecase uploadFileUsecase;
  final ListFilesUsecase listFilesUsecase;
  final GetDownloadUrlUseCase getDownloadUrlUseCase;
  final DeleteFileUsecase deleteFileUsecase;

  FileCubit(
    this.uploadFileUsecase,
    this.listFilesUsecase,
    this.getDownloadUrlUseCase,
    this.deleteFileUsecase,
  ) : super(FileInitial());

  Future<void> uploadFile(String path) async {
    emit(FileLoading());
    try {
      await uploadFileUsecase(path);
      emit(FileUploaded());
    } catch (e) {
      emit(FileFailure(e.toString()));
    }
  }

  Future<String> getDownloadUrl(String path) async {
    try {
      return await getDownloadUrlUseCase(path);
    } catch (e) {
      emit(FileFailure(e.toString()));
      return '';
    }
  }

  Future<List<FileEntity>> listFiles() async {
    emit(FileLoading());
    try {
      final files = await listFilesUsecase();
      emit(FileLoaded(files));
      return files;
    } catch (e) {
      emit(FileFailure(e.toString()));
      return [];
    }
  }

  Future<void> deleteFile(String name) async {
    emit(FileLoading());
    try {
      await deleteFileUsecase(name);
      final files = await listFilesUsecase();
      emit(FileLoaded(files));
    } catch (e) {
      emit(FileFailure(e.toString()));
    }
  }
}
