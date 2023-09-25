import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_conduit_app/models/authmodel.dart';
import 'package:rest_api_conduit_app/models/loginmodel.dart';
import 'package:rest_api_conduit_app/repo/postrepo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo repo;
  LoginBloc({required this.repo}) : super(LoginInitial()) {
    on<LoginsubmitEvent>(loginsubmitEvent);
  }
  loginsubmitEvent(LoginsubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());  
    try {
      http.Response data = await repo.login(event.requestModel);
      if (data.statusCode == 200) {
        dynamic jsonData=data.body;
        print(jsonData);
        emit(LoginLoadedState(msg: "Login Successfull"));
      } else {
        emit(LoginErrorState(error: data.body));
      }
    } on SocketException {
      emit(LoginNoInternetState(net: "Please check your Internet Connection"));
    } catch (e) {
      print(e);
      emit(LoginErrorState(error: e.toString()));
    }
  }
}
