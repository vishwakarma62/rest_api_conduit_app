import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_conduit_app/blocs/articlebyslugforsinglearticle/bloc/article_by_slug_bloc.dart';
import 'package:rest_api_conduit_app/blocs/editbloc/bloc/edit_bloc.dart';
import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/conduit/bloc/conduit_bloc.dart';
import '../intl/appcolor.dart';

class ViewData extends StatefulWidget {
  ViewData({super.key, required this.data});
  AllArticlesModel data;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  void initState() {
    getdata();
    titleCtr = TextEditingController(text: widget.data.title);
    bodyCtr = TextEditingController(text: widget.data.body);
    context.read<ArticleBySlugBloc>()
      ..add(
        ArticleBySlugClickedEvent(
          slugdata: widget.data.slug.toString(),
        ),
      );
    super.initState();
  }

  TextEditingController? titleCtr;
  TextEditingController? bodyCtr;

  String? username;

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Details",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: BlocConsumer<ArticleBySlugBloc, ArticleBySlugState>(
          listener: (context, state) {
            if (state is ArticleBySlugErrorState) {
              final geterror = state as ArticleBySlugErrorState;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${geterror.error}"),
                ),
              );
            }
            if (state is ArticleBySlugNoInternetState) {
              final mssg = state as ArticleBySlugNoInternetState;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${mssg.mssg}"),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ArticleBySlugLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ArticleBySlugErrorState) {
              return Center(
                child: InkWell(
                  onTap: () {
                    context.read<ArticleBySlugBloc>()
                      ..add(
                        ArticleBySlugClickedEvent(
                          slugdata: widget.data.slug.toString(),
                        ),
                      );
                  },
                  child: Text(
                    "please try again...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            if (state is ArticleBySlugNoInternetState) {
              return Center(
                child: InkWell(
                  onTap: () {
                    context.read<ArticleBySlugBloc>()
                      ..add(
                        ArticleBySlugClickedEvent(
                          slugdata: widget.data.slug.toString(),
                        ),
                      );
                  },
                  child: Text(
                    "please try again...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            if (state is ArticleBySlugSuccessState) {
              final success = state as ArticleBySlugSuccessState;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                            letterSpacing: 0.24,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.APiblackcolor),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                success.articledata.author!.image!),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${success.articledata.author!.username}",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.39,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                              ),
                              Text(
                                "${success.articledata.updatedAt}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.9,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          success.articledata.author!.following
                              ? Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.9,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              : Text(
                                  "Follow",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.9,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                        ],
                      ),
                      if (widget.data.author!.username == username)
                        IconButton(
                            onPressed: () {
                              _editarticle(context);
                            },
                            icon: Icon(Icons.edit)),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${success.articledata.title}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Divider(
                        thickness: 2.4,
                        color: AppColor.figmadevider.withOpacity(0.6),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            weight: 50,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "1850",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.3,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.message,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(
                        thickness: 2,
                        color: AppColor.figmadevider.withOpacity(0.6),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "${success.articledata.body}",
                        style: TextStyle(
                            fontSize: 12.5,
                            letterSpacing: 0.9,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: 25,
                        child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text("${widget.data.tagList?[index]}"),
                                )),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 5,
                              );
                            },
                            itemCount: widget.data.tagList!.length),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _editarticle(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddEditScreen(),
            ),
          );
        });
  }

  AddEditScreen() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: titleCtr,
                keyboardType: TextInputType.name,
                maxLines: 4,
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6)),
                    hintText: '${widget.data.title}'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
                maxLines: 2,
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6)),
                    hintText: 'what this article about....'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: bodyCtr,
                keyboardType: TextInputType.name,
                maxLines: 8,
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6)),
                    hintText: 'article description....'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
                height: 44,
                width: 265,
                child: ElevatedButton(
                    onPressed: () {
                      // context.read<ConduitBloc>()..add(ConduitLoadingEvent());
                      Navigator.pop(context);
                      context.read<EditBloc>()
                        ..add(
                          EditclickedEvent(
                              editdata: AllArticlesModel(
                                  title: titleCtr!.text, body: bodyCtr!.text),
                              slugdata: widget.data.slug!),
                        );
                      context.read<ArticleBySlugBloc>()
                        ..add(
                          ArticleBySlugClickedEvent(
                            slugdata: widget.data.slug.toString(),
                          ),
                        );
                    },
                    child: Text("Edit"))),
          ],
        ),
      ),
    );
  }
}
