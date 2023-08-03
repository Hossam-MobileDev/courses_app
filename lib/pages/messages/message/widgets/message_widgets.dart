import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/messages/message/message_controller.dart';

import '../../../../common/entities/message.dart';
import '../../../../common/utils/app_date.dart';

Widget buildChatList(BuildContext context, Message item, MessagesController controller) {
  return Container(
      width: 325.w,
      height: 80.h,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
      child: InkWell(
        onTap: () {
          controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${item.avatar}"),
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: BorderRadius.circular(15.h)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10.w),
                        width: 210.w,
                        child: reusableText("${item.name}",
                            color: AppColors.primaryText, fontSize: 13.sp)),
                    Container(
                      width: 210.w,
                      margin: EdgeInsets.only(left: 10.w, top:10.h),
                      child: Text(
                        "${item.last_msg}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )

                  ],
                )
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                 child: Text(
                    item.last_time==null?"":duTimeLineFormat(
                        (item.last_time as Timestamp).toDate()
                    ),
                   style: TextStyle(
                     color: AppColors.primaryThirdElementText,
                     fontSize: 10.sp,
                     fontWeight: FontWeight.normal
                   ),
                  )
                ),
                item.msg_num==0?Container():Container(
                  height: 15.h,
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minWidth: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(5.h)
                  ),
                  child: Text(
                    "${item.msg_num}",
                    style: TextStyle(
                      color: AppColors.primaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 8.sp,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ));
}
