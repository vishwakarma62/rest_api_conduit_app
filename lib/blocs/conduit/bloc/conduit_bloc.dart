// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rest_api_conduit_app/models/authmodel.dart';

import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';
import 'package:http/http.dart' as http;

part 'conduit_event.dart';
part 'conduit_state.dart';

class ConduitBloc extends Bloc<ConduitEvent, ConduitState> {
  ArticleRepository articleRepository;
  ConduitBloc(
    this.articleRepository,
  ) : super(ConduitLoadingState()) {
   on<ConduitLoadingEvent>((event, emit) async {
      emit(ConduitLoadingState());
      try {
        final articles = await articleRepository.fetchData();
        //final intdata = await articleRepository.datafetchData();

        emit(ConduitLoadedState(
          articledata: articles,
        ));
      } on SocketException {
        emit(ConduitNoInternetState(net: "please connect your internet"));
      } catch (e) {
        print(e);
        emit(ConduitErrorState(error: e.toString()));
      }
    });
   
  }

}
