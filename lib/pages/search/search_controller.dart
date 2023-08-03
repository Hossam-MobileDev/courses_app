import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/search/bloc/search_blocs.dart';
import 'package:ulearning_app/pages/search/bloc/search_events.dart';

import '../../common/apis/course_api.dart';

class MySearchController{
  late BuildContext context;
  MySearchController({required this.context});

   void init(){
      asyncLoadRecommendedData();
   }

   Future<void> asyncLoadRecommendedData() async {
     var result = await CourseAPI.recommendedCourseList();
     if(result.code==200){
       context.read<SearchBlocs>().add(TriggerSearchEvents(result.data!));
       print('load data');
     }else{
       toastInfo(msg: 'Internet error');
     }
   }

  Future<void> asyncLoadSearchData(String item) async {
     SearchRequestEntity searchRequestEntity = SearchRequestEntity();
     searchRequestEntity.search = item;
    var result = await CourseAPI.search(params: searchRequestEntity);
    if(result.code==200){
      context.read<SearchBlocs>().add(TriggerSearchEvents(result.data!));
      print('${jsonEncode(result.data!)}');
    }else{
      toastInfo(msg: 'Internet error');
    }
  }
}