import 'package:equatable/equatable.dart';

abstract class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

class GetPictureList extends PictureEvent {
  @override
  List<Object> get props => [];
}
