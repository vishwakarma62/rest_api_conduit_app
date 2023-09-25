// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  ArticleRepository favouritearticledata;
  FavouriteBloc(
    this.favouritearticledata,
  ) : super(FavouriteLoadingState()) {
    on<LoadingStartEvent>(loadingStartEvent);
  }

  FutureOr<void> loadingStartEvent(
      LoadingStartEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoadingState());
    try {
      final favourites = await favouritearticledata.favourite( );

      emit(FavouriteLoadedState(
        favouritedata: favourites,
      ));
    } on SocketException {
      emit(FavouriteNoInternetState(net: "Please connect your Internet"));
    } catch (e) {
      print(e);
      emit(FavouriteErrorState(error: e.toString()));
    }
  }
}
