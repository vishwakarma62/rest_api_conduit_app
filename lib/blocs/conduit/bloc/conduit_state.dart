// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'conduit_bloc.dart';

sealed class ConduitState extends Equatable {
  const ConduitState();

  @override
  List<Object> get props => [];
}

class ConduitLoadingState extends ConduitState {
  @override
  List<Object> get props => [];
}

class ConduitNoInternetState extends ConduitState {
  String net;
  ConduitNoInternetState({
    required this.net,
  });
  List<Object> get props => [];
}

class ConduitLoadedState extends ConduitState {
  List<AllArticlesModel> articledata;
  ConduitLoadedState({
    required this.articledata,
  });
  @override
  List<Object> get props => [articledata];
}

class ConduitErrorState extends ConduitState {
  final String error;
  ConduitErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

