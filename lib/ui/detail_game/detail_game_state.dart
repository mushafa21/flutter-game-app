part of 'detail_game_cubit.dart';

abstract class DetailGameState extends Equatable {
  const DetailGameState();
}

class DetailGameInitial extends DetailGameState {
  @override
  List<Object> get props => [];
}

class DetailGameLoading extends DetailGameState {
  @override
  List<Object> get props => [];
}

class DetailGameError extends DetailGameState {
  final String error;
  const DetailGameError({required this.error });
  @override
  List<Object> get props => [error];
}

class DetailGameSuccess extends DetailGameState {
  final GameModel response;
  const DetailGameSuccess({required this.response});
  @override
  List<Object?> get props => [response];

}
