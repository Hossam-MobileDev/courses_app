import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_states.dart';

import 'lesson_events.dart';

class LessonBlocs extends Bloc<LessonEvents, LessonStates>{
  LessonBlocs():super(const LessonStates()){
    on<TriggerLessonVideo>(_triggerLessonVideo);
    on<TriggerUrlItem>(_triggerUrlItem);
    on<TriggerPlay>(_triggerPlay);
    on<TriggerVideoIndex>(_triggerVideoIndex);
  }
  void _triggerLessonVideo(TriggerLessonVideo event, Emitter<LessonStates>emit){
    emit(state.copyWith(lessonVideoItem: event.lessonVideoItem));
  }
  void _triggerUrlItem(TriggerUrlItem event, Emitter<LessonStates>emit){
    emit(state.copyWith(initializeVideoPlayerFuture: event.initVideoPlayerFuture));
  }
  void _triggerPlay(TriggerPlay event, Emitter<LessonStates>emit){
    emit(state.copyWith(isPlay: event.isPlay));
  }
  void _triggerVideoIndex(TriggerVideoIndex event, Emitter<LessonStates>emit){
    emit(state.copyWith(videoIndex: event.videoIndex));
  }
}