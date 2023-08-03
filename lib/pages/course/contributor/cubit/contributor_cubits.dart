import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_states.dart';

class ContributorCubits extends Cubit<ContributorStates>{
   ContributorCubits():super(const ContributorStates());

   triggerContributor(AuthorItem event){
     emit(state.copyWith(authorItem:event));
   }

   triggerCourseItemChange(List<CourseItem> event){
     emit(state.copyWith(courseItem:event));
   }
}