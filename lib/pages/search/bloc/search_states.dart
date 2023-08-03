import '../../../common/entities/course.dart';

class SearchStates {
  const SearchStates({
    this.courseItem = const <CourseItem>[]
  });

  final List<CourseItem> courseItem;

  SearchStates copyWith({List<CourseItem>? courseItem}){
    return SearchStates(courseItem: courseItem??this.courseItem);
  }

}