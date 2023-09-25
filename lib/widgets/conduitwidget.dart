import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_conduit_app/blocs/articlebyslugforsinglearticle/bloc/article_by_slug_bloc.dart';
import 'package:rest_api_conduit_app/blocs/conduit/bloc/conduit_bloc.dart';
import 'package:rest_api_conduit_app/blocs/conduitfavourite/bloc/favourite_bloc.dart';
import 'package:rest_api_conduit_app/blocs/delete/bloc/delete_bloc.dart';
import 'package:rest_api_conduit_app/blocs/editbloc/bloc/edit_bloc.dart';

import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';
import 'package:rest_api_conduit_app/ui/viewdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/like/bloc/liked_bloc.dart';
import '../blocs/like/bloc/liked_event.dart';
import '../intl/appcolor.dart';

class ConduitWidget extends StatefulWidget {
  ConduitWidget({
    super.key,
    required this.article,
    required this.articlerepo,
  });
  AllArticlesModel article;
  ArticleRepository articlerepo;
  bool iscreated = false;
  var data;

  @override
  State<ConduitWidget> createState() => _ConduitWidgetState();
}

class _ConduitWidgetState extends State<ConduitWidget>
    with SingleTickerProviderStateMixin {
  var data;
  bool? isfavourite;
  late LikeBloc likeBloc;
  late EditBloc editBloc;
  TextEditingController? titleCtr;
  TextEditingController? bodyCtr;
  @override
  void initState() {
    setState(() {
      getdata();

      editBloc = context.read<EditBloc>();
      likeBloc = context.read<LikeBloc>();
      isfavourite = widget.article.favorited;

      titleCtr = TextEditingController(text: widget.article.title);
      bodyCtr = TextEditingController(text: widget.article.body);
    });
    super.initState();
  }

  changeLikeState() {
    setState(() {
      isfavourite = !isfavourite!;
      if (isfavourite!) {
        likeBloc.add(LikeArticleEvent(slug: widget.article.slug!));
      } else {
        likeBloc.add(RemoveLikeArticleEvent(slug: widget.article.slug!));
      }
    });
  }

  String? username;
  void getdata() async {
    print(widget.article.favorited);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
  }

 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewData(
            data: widget.article,
          );
        }));
      },
      onLongPress: () {
        context.read<DeleteBloc>()
          ..add(DeleteclickedEvent(slugdata: widget.article.slug.toString()));

        context.read<ConduitBloc>()..add(ConduitLoadingEvent());
      },
      child: Container(
        margin: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4), blurRadius: 2, color: AppColor.lightgray)
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("${widget.article.author!.image}"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.article.author!.username}",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.39,
                          fontWeight: FontWeight.w700,
                          color: AppColor.APiblackcolor,
                        ),
                      ),
                      Text(
                        "${widget.article.updatedAt}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.9,
                            color: AppColor.ratting),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text(
                  "${widget.article.title}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.24,
                      color: AppColor.APiblackcolor),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text(
                  "${widget.article.body}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12.5,
                      // fontWeight: FontWeight.w400,
                      letterSpacing: 0.9,
                      color: AppColor.APitext),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 25,
                child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.APi),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "${widget.article.tagList?[index]}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.6),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: widget.article.tagList!.length),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: changeLikeState,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: isfavourite!
                          ? Icon(
                              Icons.favorite,
                              size: 25,
                              color: Colors.green,
                              key: ValueKey<int>(1),
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                              size: 25,
                              key: ValueKey<int>(2),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: AppColor.APimessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
