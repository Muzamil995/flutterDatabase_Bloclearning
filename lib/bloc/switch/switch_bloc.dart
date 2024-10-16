import 'package:bloc/bloc.dart';
import 'package:database_practice/bloc/switch/switch_event.dart';
import 'package:database_practice/bloc/switch/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState(isSwitch: false)) {
    on<EnableOrDisableNotification>(_enableorDisableNotification);
    on<SliderEvent>(_slider);
  }
  void _enableorDisableNotification(
      EnableOrDisableNotification events, Emitter<SwitchState> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent events, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: events.slider));
  }
}
