import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/commentbloc/bloc/comment_bloc.dart';
import '../intl/appcolor.dart';
import '../models/comment.dart';

class CommentWidget extends StatefulWidget {
  CommentWidget({
    Key? key,
    required this.commentModel,
  }) : super(key: key);
  CommentModel commentModel;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
 

  @override
  initState() {
    super.initState();
   

    // commentIdStore();
  }

  // commentIdStore() async {
  //   if (widget.commentModel.id != "")
  //     sharedPreferencesStore.storeCommentId(
  //       await widget.commentModel.id!,
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.commentModel.body ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    "assets/icons/user_foreground.png",
                  ),
                  foregroundImage:
                      NetworkImage(widget.commentModel.author?.image ?? ''),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.commentModel.author?.username ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (widget.commentModel.createdAt ?? ''),
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red[400],
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
