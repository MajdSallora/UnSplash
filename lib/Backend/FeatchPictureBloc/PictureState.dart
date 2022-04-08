import 'package:equatable/equatable.dart';
import '../model/ModelPicture.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object?> get props => [];
}

class PictureInitial extends PictureState {}

class PictureLoading extends PictureState {
  final List<ModelPicture> oldPhoto;
  final bool isFirstFetch;

  PictureLoading(this.oldPhoto, {this.isFirstFetch = false});
}

class PictureLoaded extends PictureState {
  final List<ModelPicture> photoModel;

  const PictureLoaded(this.photoModel);

  List<Object> get props => [];
}

class PictureError extends PictureState {
  final String? message;

  const PictureError(this.message);
}
