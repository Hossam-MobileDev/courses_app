import 'package:ulearning_app/common/entities/course.dart';

class ContributorStates {
  final AuthorItem? authorItem;
  final List<CourseItem> courseItem;

  const ContributorStates(
      {this.authorItem, this.courseItem = const <CourseItem>[]});

  ContributorStates copyWith(
      {AuthorItem? authorItem, List<CourseItem>? courseItem}) {
    return ContributorStates(
        authorItem: authorItem ?? this.authorItem,
        courseItem: courseItem ?? this.courseItem);
  }
}
