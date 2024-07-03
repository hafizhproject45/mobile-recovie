// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ImagePosterEntity extends Equatable {
  final String? filePath;

  const ImagePosterEntity({
    this.filePath,
  });

  @override
  List<Object?> get props {
    return [filePath];
  }
}
