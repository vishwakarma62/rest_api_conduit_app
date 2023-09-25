// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  ArticleRepository repo;
  EditBloc(
    this.repo,
  ) : super(EditLoadingState()) {
    on<EditclickedEvent>(editclickedEvent);
  }

  FutureOr<void> editclickedEvent(
      EditclickedEvent event, Emitter<EditState> emit) async {
    emit(EditLoadingState());
    try {
      dynamic data = await repo.editArticle(event.editdata, event.slugdata);
      if (data == true) {
        print("edit successfull");
        emit(EditSuccessState(
            mssg: "edit successfull"));
      }
    } on SocketException {
      print("connect your net");
      emit(EditNoInternetState(net: "connect your net"));
    } catch (e) {
      print(e.toString());
      emit(
        EditErrorState(error: e.toString()),
      );
    }
  }
}
