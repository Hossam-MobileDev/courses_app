import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_cubits.dart';

import '../../../common/apis/course_api.dart';
import '../../../global.dart';

class ContributorController {
  late BuildContext context;

  ContributorController({required this.context});

  UserItem userProfile = Global.storageService.getUserProfile();
  var db = FirebaseFirestore.instance; //cloud firestore

  void init() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAuthorData(args['token']);
    asyncLoadAuthorCourseData(args['token']);
  }

  Future<void> goChat(AuthorItem author) async {
    print('--${author.token}--');
    if (author.token == userProfile.token) {
      toastInfo(msg: "Can't chat to yourself");
      return;
    }
    //you sent to someone special
    var fromMessages =
    await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_token', isEqualTo: userProfile.token) //the one trying to chat
        .where("to_token", isEqualTo: author.token) //the one trying to chat to
        .get();
    //someone special sent messages to you
    var toMessages =
    await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_token', isEqualTo: userProfile.token) //sending to you
        .where("from_token", isEqualTo: author.token) //from the certain guy
        .get();
    //check if we had a chat before
    if(fromMessages.docs.isEmpty && toMessages.docs.isEmpty){
      //we never had a chat
      var msgData = Msg(
        from_token: userProfile.token,
        to_token: author.token,
        from_name: userProfile.name,
        to_name: author.name,
        from_avatar: userProfile.avatar,
        to_avatar: author.avatar,
        from_online: userProfile.online,
        to_online: author.online,
        last_msg:"",
        last_time: Timestamp.now(),
        msg_num: 0
      );
      var docId = await db.collection("message").withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore()
      ).add(msgData);


      Navigator.of(context).pushNamed(AppRoutes.CHAT,
          arguments: {
            "doc_id":docId.id,
            "to_token":author.token??"",
            "to_name":author.name??"",
            "to_avatar":author.avatar??"",
            "to_online":author.online.toString()
          }

      );

      //navigate to chat page

    }else{
      if(fromMessages.docs.isNotEmpty){
        Navigator.of(context).pushNamed(AppRoutes.CHAT,
          arguments: {
            "doc_id":fromMessages.docs.first.id,
            "to_token":author.token??"",
            "to_name":author.name??"",
            "to_avatar":author.avatar??"",
            "to_online":author.online.toString()
          }

        );
      }

      if(toMessages.docs.isNotEmpty){
        Navigator.of(context).pushNamed(AppRoutes.CHAT,
            arguments: {
              "doc_id":toMessages.docs.first.id,
              "to_token":author.token??"",
              "to_name":author.name??"",
              "to_avatar":author.avatar??"",
              "to_online":author.online.toString()
            }

        );
      }


    }

  }

  Future<void> asyncLoadAuthorData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.courseAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<ContributorCubits>().triggerContributor(result.data!);
        var res =
            jsonEncode(context.read<ContributorCubits>().state.authorItem);
        print('my author is ${res}');
      }
    }
  }

  Future<void> asyncLoadAuthorCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.courseListAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<ContributorCubits>().triggerCourseItemChange(result.data!);
      }
    }
  }
}
