// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'conduit_bloc.dart';

sealed class ConduitEvent extends Equatable {
  const ConduitEvent();

  @override
  List<Object> get props => [];
}
class ConduitLoadingEvent extends ConduitEvent{}

