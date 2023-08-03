import '../../../common/entities/course.dart';

abstract class SearchEvents{}

class TriggerSearchEvents extends SearchEvents{
  TriggerSearchEvents(this.courseItem);
  final List<CourseItem> courseItem;
}