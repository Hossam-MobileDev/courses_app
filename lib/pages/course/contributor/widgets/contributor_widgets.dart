import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widgets/image_widgets.dart';

import '../../../../common/routes/names.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/widgets/base_text_widget.dart';
import '../cubit/contributor_states.dart';

Widget backgroundImage() {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h),
        image: const DecorationImage(
          image: AssetImage("assets/icons/background.png"),
          fit: BoxFit.fitWidth,
        )),
  );
}

Widget authorView(BuildContext context, ContributorStates state) {
  return Container(
    width: 325.w,
    margin: EdgeInsets.only(left: 20.w, bottom: 5.w),
    child: state.authorItem == null
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //author's profile photo
              cachedNetworkImage(state.authorItem!.avatar ?? "",
                  width: 80.w,
                  height: 80.h,
                  defaultImage: "assets/icons/person(1).png"),

              //author bio
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  //author's name
                  Container(
                    margin: EdgeInsets.only(left: 6.w, bottom: 8.h),
                    child: reusableText(state.authorItem?.name ?? "Unknown",
                        color: AppColors.primaryText, fontSize: 13),
                  ),
                  //author's job
                  Container(
                    margin: EdgeInsets.only(left: 6.w, bottom: 8.h),
                    child: reusableText(state.authorItem?.job ?? "Instructor",
                        color: AppColors.primarySecondaryElementText,
                        fontSize: 9,
                        fontWeight: FontWeight.normal),
                  ),
                  //author's popularity
                  authorsPopularity()
                ],
              )
            ],
          ),
  );
}

Widget authorsPopularity() {
  return Row(
    children: [
      //author's fans
      _iconAndNum("assets/icons/people.png", 121),
      SizedBox(
        width: 5.w,
      ),
      _iconAndNum("assets/icons/star.png", 12),
      SizedBox(
        width: 5.w,
      ),
      _iconAndNum("assets/icons/download.png", 102),
    ],
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    //margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 16.w,
          height: 16.h,
        ),
        reusableText(num.toString(),
            color: AppColors.primaryThirdElementText,
            fontSize: 11.sp,
            fontWeight: FontWeight.normal)
      ],
    ),
  );
}

Widget authorsDescription(ContributorStates state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //about me text
      reusableText(
        "About me",
        color: AppColors.primaryText,
      ),
      //about authors description
      state.authorItem == null
          ? Container()
          : reusableText(
              state.authorItem!.description ?? "No description found",
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 11.sp,
            )
    ],
  );
}

Widget authorCourseList(ContributorStates state) {
  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.courseItem.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 325.w,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1))
                ]),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.COURSE_DETAIL ,
                  arguments: {
                    "id":state.courseItem[index].id
                  }

                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //for image and the text
                  Row(
                    children: [
                      cachedNetworkImage(
                          "${AppConstants.SERVER_UPLOADS}${state.courseItem[index].thumbnail!}",
                           width: 60.w,
                        height: 60.h,
                        defaultImage: "assets/icons/image(1).png"
                          ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //list item title
                          listItemContainer(
                              state.courseItem[index].name.toString()),
                          //list item description
                          listItemContainer(
                              state.courseItem[index].description.toString(),
                              fontSize: 10,
                              color: AppColors.primaryThirdElementText,
                              fontWeight: FontWeight.normal)
                        ],
                      )
                    ],
                  ),
                  //for showing the right arrow
                  Container(
                    child: Image(
                      height: 24.h,
                      width: 24.h,
                      image: AssetImage("assets/icons/arrow_right.png"),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}
