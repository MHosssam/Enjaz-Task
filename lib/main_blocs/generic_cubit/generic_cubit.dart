// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generic_state.dart';

class GenericBloc<T> extends Cubit<GenericState<T>> {
  GenericBloc(T data) : super(GenericInitialState<T>(data));

  onUpdateToInitState(T data) {
    emit(GenericInitialState<T>(data));
  }

  onLoading({String error = ""}) {
    emit(GenericLoadingState<T>(state.data, !state.changed, state.error));
  }

  onUpdateData(T data) {
    emit(GenericUpdateState<T>(data, !state.changed, state.error));
  }

  onFailedResponse({String error = ""}) {
    emit(GenericFailedState<T>(state.data, !state.changed, error));
  }

  onNetworkExeption({String error = ""}) {
    emit(GenericNetworkExeptionState<T>(state.data, !state.changed, error));
  }
}
