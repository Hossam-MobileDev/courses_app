

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_states.dart';
import 'package:ulearning_app/pages/course/lesson/lesson_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/entities/lesson.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/widgets/base_text_widget.dart';
import '../../../../common/widgets/flutter_toast.dart';
import '../bloc/lesson_blocs.dart';
import '../bloc/lesson_events.dart';

Widget videoPlayer(LessonStates state, LessonController lessonController){

  return state.lessonVideoItem.isEmpty?Container():Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
        image:  DecorationImage(
            image:
            NetworkImage(
                state.lessonVideoItem[state.videoIndex].thumbnail!
            ),
            fit: BoxFit.fitWidth),
        borderRadius: BorderRadius.circular(0.h)),
    child: FutureBuilder(
      future: state.initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        print(
            '----video snapshot is ${snapshot.connectionState}----');
        //check if the connection is made to the certain video on the server
        if (snapshot.connectionState ==
            ConnectionState.done) {
          return lessonController
              .videoPlayerController ==
              null
              ? Container()
              : AspectRatio(
            aspectRatio: lessonController
                .videoPlayerController!
                .value
                .aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(lessonController
                    .videoPlayerController!),
                VideoProgressIndicator(
                  lessonController
                      .videoPlayerController!,
                  allowScrubbing: true,
                  colors:
                  const VideoProgressColors(
                      playedColor: AppColors
                          .primaryElement),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}

Widget videoControls(LessonStates state, LessonController lessonController, BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //left button
        GestureDetector(
          onTap: () {
            var videoIndex = context.read<LessonBlocs>().state.videoIndex;
            videoIndex = videoIndex-1;
            if(videoIndex<0){
              videoIndex=0;
              context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
              toastInfo(msg: "This is the first video you are watching");
              return;
            }else{
              var videoItem = state.lessonVideoItem.elementAt(videoIndex);
              lessonController.playVideo(videoItem.url!);
            }
            context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
          },
          child: Container(
            width: 24.w,
            height: 24.w,
            margin: EdgeInsets.only(right: 15.w),
            child: Image.asset(
                "assets/icons/rewind-left.png"),
          ),
        ),
        //play and pause button
        GestureDetector(
            onTap: () {
              //if it's already playing
              if (state.isPlay) {
                lessonController
                    .videoPlayerController
                    ?.pause();
                context
                    .read<LessonBlocs>()
                    .add(const TriggerPlay(false));
              } else {
                //if it's not playing, then play
                lessonController
                    .videoPlayerController
                    ?.play();
                context
                    .read<LessonBlocs>()
                    .add(const TriggerPlay(true));
              }
            },
            child: state.isPlay
                ? Container(
              width: 24.w,
              height: 24.w,
              child: Image.asset(
                  "assets/icons/pause.png"),
            )
                : Container(
              width: 24.w,
              height: 24.w,
              child: Image.asset(
                  "assets/icons/play-circle.png"),
            )),
        //right videos
        GestureDetector(
          onTap: () {
            var videoIndex = context.read<LessonBlocs>().state.videoIndex;
            videoIndex = videoIndex+1;
            if(videoIndex>=state.lessonVideoItem.length){
              //otherwise you will get overflow
              videoIndex=videoIndex-1;
              toastInfo(msg: "No videos in the play list");
              context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
              return;
            }else{
              var videoItem = state.lessonVideoItem.elementAt(videoIndex);
              lessonController.playVideo(videoItem.url!);
            }
            context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
          },
          child: Container(
            width: 24.w,
            height: 24.w,
            margin: EdgeInsets.only(left: 15.w),
            child: Image.asset(
                "assets/icons/rewind-right.png"),
          ),
        ),
      ],
    ),
  );
}

//video list
SliverPadding videoList(LessonStates state, LessonController lessonController){
  return SliverPadding(

    padding:EdgeInsets.symmetric(
      vertical: 18.h,
      horizontal: 25.w,
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
              (context, index){
            return _buildLessonItems(context, index, state.lessonVideoItem[index], lessonController);
          },
          childCount: state.lessonVideoItem.length
      ),
    ),
  );
}
Widget _buildLessonItems(BuildContext context, int index, LessonVideoItem item, LessonController lessonController){
  return Container(
    width: 325.w,
    height: 80.h,
    margin: EdgeInsets.only(
        bottom: 20.h
    ),
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: const Color.fromRGBO(255, 255, 255, 1),
        //color: Colors.red,
        boxShadow: [
          BoxShadow(
              color:Colors.grey.withOpacity(.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 1)
          )
        ]

    ),
    child: InkWell(
      onTap: (){
        //videoIndex = index;
        context.read<LessonBlocs>().add(TriggerVideoIndex(index));
        lessonController.playVideo(item.url!);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage("${item.thumbnail}")
                    )
                ),
              ),
              Container(
                width: 210.h,
                height: 60.h,
                alignment: Alignment.centerLeft,

                margin: EdgeInsets.only(left: 6.sp),
                child: reusableText(
                    "${item.name}",
                    fontSize: 13.sp
                ),
              )
            ],
          ),
          Row(

            children: [
              GestureDetector(
                onTap: (){
                  context.read<LessonBlocs>().add(TriggerVideoIndex(index));
                  lessonController.playVideo(item.url!);
                },
                child: Image.asset(
                    width:24.w,
                    height:24.w,
                    "assets/icons/play-circle.png"
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
