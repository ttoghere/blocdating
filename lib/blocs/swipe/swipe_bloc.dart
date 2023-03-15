import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocdating/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsersEvent);
    on<SwipeRightEvent>(_onSwipeRightEvent);
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
  }

  void _onLoadUsersEvent(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) {
    emit(SwipeLoaded(users: event.users));
  }

  void _onSwipeLeftEvent(
    SwipeLeftEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(
          SwipeLoaded(
            users: List.from(state.users)..remove(event.user),
          ),
        );
      } catch (_) {}
    }
  }

  void _onSwipeRightEvent(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(
          SwipeLoaded(
            users: List.from(state.users)..remove(event.user),
          ),
        );
      } catch (_) {}
    }
  }
}
