import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_events.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_states.dart';

class ChatBlocs extends Bloc<ChatEvents, ChatStates>{
  ChatBlocs():super(ChatStates()){
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
    on<TriggerMoreStatus>(_triggerMoreStatus);
    on<TriggerClearMsgList>(_triggerClearMsgList);
    on<TriggerLoadMsgData>(_triggerLoadMsgData);
  }


  void _triggerMsgContentList(TriggerMsgContentList event, Emitter<ChatStates> emit){
    //get the total messages
    var res = state.msgcontentList.toList();
    //below is the single message
    res.insert(0, event.msgContentList);

    //res.add(event.msgContentList);
    emit(state.copyWith(msgcontentList: res));
  }


  void _triggerAddMsgContent(TriggerAddMsgContent event, Emitter<ChatStates> emit){
    var res = state.msgcontentList.toList();
    res.add(event.msgContent);
    emit(state.copyWith(msgcontentList: res));
  }

  void _triggerMoreStatus(TriggerMoreStatus event, Emitter<ChatStates> emit){
    emit(state.copyWith(more_status: event.moreStatus));
  }

  //we need to trigger to null or empty the list, otherwise we will have duplicate message
  void _triggerClearMsgList(TriggerClearMsgList event, Emitter<ChatStates> emit){
    emit(state.copyWith(msgcontentList: []));
  }

  void _triggerLoadMsgData(TriggerLoadMsgData event, Emitter<ChatStates> emit){
    emit(state.copyWith(is_loading: event.isloading));
  }

}