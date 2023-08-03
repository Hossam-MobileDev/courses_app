import 'package:equatable/equatable.dart';
import 'package:ulearning_app/common/entities/entities.dart';

abstract class LessonEvents extends Equatable{
  const LessonEvents();
  @override
  List<Object?> get props => [];
}

class TriggerLessonVideo extends LessonEvents{
  const TriggerLessonVideo(this.lessonVideoItem);
  final List<LessonVideoItem> lessonVideoItem;
  @override
  List<Object?> get props => [lessonVideoItem];
}

class TriggerUrlItem extends LessonEvents{
  final Future<void>? initVideoPlayerFuture;
  const TriggerUrlItem(this.initVideoPlayerFuture);
  @override
  List<Object?> get props => [initVideoPlayerFuture];
}

class TriggerPlay extends LessonEvents{
  final bool isPlay;
  const TriggerPlay(this.isPlay);
  @override
  List<Object?> get props => [isPlay];
}
class TriggerVideoIndex extends LessonEvents{
  final int videoIndex;
  const TriggerVideoIndex(this.videoIndex);
  @override
  List<Object?> get props => [videoIndex];
}