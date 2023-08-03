import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/search/bloc/search_events.dart';
import 'package:ulearning_app/pages/search/bloc/search_states.dart';

class SearchBlocs extends Bloc<SearchEvents, SearchStates> {
  SearchBlocs() : super(const SearchStates()) {
    on<TriggerSearchEvents>(_triggerSearchEvents);
  }

  _triggerSearchEvents(TriggerSearchEvents event, Emitter<SearchStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
