import '../../domain/entities/file_entity.dart';

abstract class FileState {}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileUploaded extends FileState {}

class FileLoaded extends FileState {
  final List<FileEntity> files;

  FileLoaded(this.files);
}

class FileFailure extends FileState {
  final String message;

  FileFailure(this.message);
}