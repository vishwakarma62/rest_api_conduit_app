import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_conduit_app/blocs/articlebyslugforsinglearticle/bloc/article_by_slug_bloc.dart';
import 'package:rest_api_conduit_app/blocs/conduit/bloc/conduit_bloc.dart';
import 'package:rest_api_conduit_app/blocs/conduitfavourite/bloc/favourite_bloc.dart';
import 'package:rest_api_conduit_app/blocs/createarticles/bloc/creat_article_bloc.dart';
import 'package:rest_api_conduit_app/blocs/editbloc/bloc/edit_bloc.dart';
import 'package:rest_api_conduit_app/blocs/like/bloc/liked_bloc.dart';
import 'package:rest_api_conduit_app/blocs/login/bloc/login_bloc.dart';
import 'package:rest_api_conduit_app/blocs/signup/bloc/sign_up_bloc.dart';
import 'package:rest_api_conduit_app/repo/postrepo.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';
import 'package:rest_api_conduit_app/ui/bottomnavigationar.dart';
import 'package:rest_api_conduit_app/ui/conduit_screen.dart';
import 'package:rest_api_conduit_app/ui/loginpage.dart';
import 'package:rest_api_conduit_app/ui/splash.dart';
import 'package:rest_api_conduit_app/ui/viewdata.dart';
import 'package:rest_api_conduit_app/widgets/conduitwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/delete/bloc/delete_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConduitBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(repo: AuthImpl()),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(signUpRepository: AuthImpl()),
        ),
        BlocProvider(
          create: (context) => FavouriteBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => LikeBloc(repo: ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => EditBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => DeleteBloc(ArticleRepository()),
        ),
          BlocProvider(
          create: (context) => CreatArticleBloc(ArticleRepository()),
        ),
           BlocProvider(
          create: (context) => ArticleBySlugBloc(ArticleRepository()),
        ),
        
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
    );
  }
}
