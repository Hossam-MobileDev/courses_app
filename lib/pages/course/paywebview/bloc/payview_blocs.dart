import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_events.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_states.dart';

class PayWebViewBlocs extends Bloc<PayWebViewEvents, PayWebViewStates>{
  PayWebViewBlocs():super(const PayWebViewStates()){
    on<TriggerWebView>(_triggerWebView);
  }

  void _triggerWebView(TriggerWebView event, Emitter<PayWebViewStates> emit){
    emit(state.copyWith(url:event.url));
  }
}