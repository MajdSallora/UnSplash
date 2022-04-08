import 'package:equatable/equatable.dart';
import '../model/ModelPicture.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  final List<ModelPicture> oldPhoto;

  SearchLoading(this.oldPhoto);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  List<ModelPicture> photos;

  SearchLoaded({required this.photos});

  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
