import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/repo/repository.dart';
import 'package:rest_api_conduit_app/widgets/conduitwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/conduit/bloc/conduit_bloc.dart';

class ConduitScreen extends StatefulWidget {
  const ConduitScreen({super.key});

  @override
  State<ConduitScreen> createState() => _ConduitScreenState();
}

 


class _ConduitScreenState extends State<ConduitScreen> {
  @override
  void initState() {
    getdata();
    context.read<ConduitBloc>()..add(ConduitLoadingEvent());
    super.initState();
  }
    String? username;
void getdata()async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  username=prefs.getString('username');

}

  Future<void> refreshdata() async {
    context.read<ConduitBloc>()..add(ConduitLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConduitBloc, ConduitState>(
        listener: (context, state) {
          if (state is ConduitErrorState) {
            final geterror = state as ConduitErrorState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(duration: Duration(seconds: 2),content: Text("${geterror.error}")));
          }

          if (state is ConduitNoInternetState) {
            final net = state as ConduitNoInternetState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(duration: Duration(seconds: 2),content: Text("${net.net}")));
          }
        },
        child: BlocBuilder<ConduitBloc, ConduitState>(
          builder: (context, state) {
            if (state is ConduitLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ConduitNoInternetState) {
              return Center(
                child: InkWell(
                    onTap: () {
                      context.read<ConduitBloc>()..add(ConduitLoadingEvent());
                    },
                    child: Text("please try again...")),
              );
            }
            if (state is ConduitErrorState) {
              return Center(
                child: InkWell(
                    onTap: () {
                      context.read<ConduitBloc>()..add(ConduitLoadingEvent());
                    },
                    child: Text("please try again...")),
              );
            }
            if (state is ConduitLoadedState) {
              //final load = state as ConduitLoadedState;
              List<AllArticlesModel> articlelist = state.articledata;

              return RefreshIndicator(
                onRefresh: refreshdata,
                child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ConduitWidget(
                        article: articlelist[index],
                        articlerepo: ArticleRepository(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: 14,
                      );
                    },
                    itemCount: articlelist.length),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
