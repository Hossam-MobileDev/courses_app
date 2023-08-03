import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:video_player/video_player.dart';

import '../../../common/apis/lesson_api.dart';

class LessonController {
  final BuildContext context;
  VideoPlayerController? videoPlayerController;

  LessonController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    //set the earlier video to false means, stop playing
    context.read<LessonBlocs>().add(TriggerPlay(false));
    await asyncLoadLessonData(args['id']);
  }

  Future<void> asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonDetail(params: lessonRequestEntity);
    if(result.code==200){
      if(context.mounted){
        context.read<LessonBlocs>().add(TriggerLessonVideo(result.data!));
        if(result.data!.isNotEmpty){
          var url = result.data!.elementAt(0).url;
          print('my url is ${url}');
          //this url is important for init video player
          videoPlayerController = VideoPlayerController.network(url!);
          //here actually stream starts to happen
          var initPlayer = videoPlayerController?.initialize();
          context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
        }
      }
    }
  }

  void playVideo(String url){
    if(videoPlayerController!=null){
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }
    videoPlayerController = VideoPlayerController.network(url);
    context.read<LessonBlocs>().add(const TriggerPlay(false));
    context.read<LessonBlocs>().add(const TriggerUrlItem(null));
    var initPlayer =
        videoPlayerController?.initialize().then((_){
          videoPlayerController?.seekTo(const Duration(milliseconds: 0));
        });
    context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
    context.read<LessonBlocs>().add(const TriggerPlay(true));
    videoPlayerController?.play();
  }

}
