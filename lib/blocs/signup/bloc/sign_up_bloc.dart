// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rest_api_conduit_app/models/authmodel.dart';
import 'package:rest_api_conduit_app/repo/postrepo.dart';
import 'package:http/http.dart' as http;
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepo signUpRepository;
  SignUpBloc({
    required this.signUpRepository,
  }) : super(SignUpInitial()) {
    on<SignUPSubmitEvent>(signUPSubmitEvent);
  }

  FutureOr<void> signUPSubmitEvent(
      SignUPSubmitEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      http.Response data = await signUpRepository.signup(event.signup);
      print(data.statusCode);
      if (data.statusCode == 200 || data.statusCode == 201) {
        emit(SignUpLoaded(masg: "SignUp Successfull"));
      } else {
        emit(SignUpErrorState(error: data.body));
      }
    } on SocketException {
      emit(SignUponNoInternet(net: "Please check your Internet Connection"));
    } catch (e) {
      emit(SignUpErrorState(error: e.toString()));
    }
  }
}


// on<SignUPSubmitEvent>((event, emit) async {
//       emit(SignUpLoading());

//       try {
//         http.Response data = await signUpRepository.signup(event.signup);
//         if (data.statusCode == 200) {
//           emit(SignUpLoaded(masg: "SignUp Successfull"));
//         } else if (data.statusCode == 403) {
//           print(data.body);
//           emit(SignUpErrorState(error: data.body));
//         }
//       } on SocketException {
//         emit(SignUponNoInternet(net: "Please check your Internet Connection"));
//       } catch (e) {
//         print(e);
//         emit(SignUpErrorState(error: e.toString()));
//       }
//     });