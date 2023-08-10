part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final String error;
  const HomeError({required this.error });
  @override
  List<Object> get props => [error];
}

class HomeSuccess extends HomeState {
  final ListGameResponse response;
  const HomeSuccess({required this.response});
  @override
  List<Object?> get props => [response];

}
