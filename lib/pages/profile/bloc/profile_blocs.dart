import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_events.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_states.dart';

class ProfileBlocs extends Bloc<ProfileEvents, ProfileStates>{
   ProfileBlocs():super(const ProfileStates()){
    on<TriggerProfileName>(_triggerProfileName);
  }

  _triggerProfileName(TriggerProfileName event, Emitter<ProfileStates> emit){
    emit(state.copyWith(userProfile: event.userProfile));
  }
}