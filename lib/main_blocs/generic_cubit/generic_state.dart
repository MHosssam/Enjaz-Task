part of 'generic_cubit.dart';

abstract class GenericState<T> extends Equatable {
  final T data;
  final bool changed;
  final String error;
  const GenericState(this.data, this.changed, this.error);
}

class GenericInitialState<T> extends GenericState<T> {
  const GenericInitialState(T data) : super(data, false, "");

  @override
  List<Object> get props => [changed];
}

class GenericUpdateState<T> extends GenericState<T> {
  const GenericUpdateState(super.data, super.changed, super.error);

  @override
  List<Object> get props => [changed];
}

class GenericLoadingState<T> extends GenericState<T> {
  const GenericLoadingState(super.data, super.changed, super.error);

  @override
  List<Object> get props => [changed];
}

class GenericFailedState<T> extends GenericState<T> {
  const GenericFailedState(super.data, super.changed, super.error);

  @override
  List<Object> get props => [changed, error];
}

class GenericNetworkExeptionState<T> extends GenericState<T> {
  const GenericNetworkExeptionState(super.data, super.changed, super.error);

  @override
  List<Object> get props => [changed];
}
