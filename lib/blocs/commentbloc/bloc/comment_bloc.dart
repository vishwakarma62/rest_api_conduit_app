// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:rest_api_conduit_app/repo/repository.dart';

// import '../../../models/comment.dart';
// import 'comment_event.dart';
// import 'comment_state.dart';


// class CommentBloc extends Bloc<CommentEvent, CommentState> {
//   ArticleRepository repo;
//   CommentBloc({required this.repo}) : super(CommentInitialState()) {
//     on<fetchCommentEvent>(_onFetchCommentEvent);
//     on<deleteCommentEvent>(_onDeleteCommentEvent);
//   }
//   _onFetchCommentEvent(
//       fetchCommentEvent event, Emitter<CommentState> emit) async {
//     try {
//       emit(CommentLoadingState());
//       List<CommentModel> data = await repo.getComment(event.slug);
//       if (data.isEmpty) {
//         emit(NoCommentState());
//       } else {
//         emit(CommentSuccessState(commentModel: data));
//       }
//     } on SocketException {
//       emit(CommentNoInternetState());
//     } catch (e) {
//       emit(
//         CommentErrorState(
//           msg: e.toString(),
//         ),
//       );
//     }
//   }

//   _onDeleteCommentEvent(
//       deleteCommentEvent event, Emitter<CommentState> emit) async {
//     try {
//       emit(CommentLoadingState());
//       dynamic data = await repo.deleteComment(event.commentId, event.slug);
//       if (data == 1) {
//         emit(DeleteCommentSuccessState());
//       } else {
//         emit(DeleteCommentErrorState(
//             msg: "Something want wrong please try again later"));
//       }
//     } on SocketException {
//       emit(CommentNoInternetState());
//     } catch (e) {
//       emit(
//         CommentErrorState(
//           msg: e.toString(),
//         ),
//       );
//     }
//   }
// }