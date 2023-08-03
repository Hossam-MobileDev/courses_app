import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/common/widgets/image_widgets.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:ulearning_app/pages/course/course_detail/widgets/course_detail_widgets.dart';


import '../../../common/values/constant.dart';
import 'bloc/course_detail_blocs.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late CourseDetailController _courseDetailController;
  @override
  void initState(){
    super.initState();

  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 0), (){
      _courseDetailController = CourseDetailController(context: context);
      _courseDetailController.init();
    });

  }

  @override
  Widget build(BuildContext context) {
    int i=0;
    print("------ my build method -------");
    return BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state){
        //  print('course id ${state.courseItem!.id}');
          return state.courseItem==null?const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ):Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar("Course detail"),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //first big image
                           // thumbNail(state.courseItem!.thumbnail.toString()),
                            cachedNetworkImage(
                              "${AppConstants.SERVER_UPLOADS}${state.courseItem!.thumbnail}",
                              width: 325.w,
                              height: 200.h,
                              defaultImage: "assets/icons/image_2.png",
                              boxFit: BoxFit.fitWidth,
                            ),
                            SizedBox(height: 15.h,),
                            //three buttons or menus
                            menuView(context, state),
                            SizedBox(height: 15.h,),
                            //course description title
                            reusableText("Course Description"),
                            SizedBox(height: 15.h,),
                            //course description
                            descriptionText(state.courseItem!.description.toString()),
                            SizedBox(height: 20.h,),
                            //course buy button
                            GestureDetector(
                              onTap: (){
                                _courseDetailController.goBuy(state.courseItem!.id);
                              },
                              child: appPrimaryButton("Go buy"),
                            ),

                            SizedBox(height: 20.h,),
                            //course summary title
                            courseSummaryTitle(),

                            //course summary in list
                            courseSummaryView(context, state),
                            SizedBox(height: 20.h,),
                            //Lesson list title
                            reusableText("Lesson List"),
                            SizedBox(height: 20.h,),
                            //Course lesson list
                            courseLessonList(state)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            ,
          );
        },

    );
  }
}
