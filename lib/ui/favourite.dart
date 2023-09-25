import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:rest_api_conduit_app/blocs/conduit/bloc/conduit_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/conduitfavourite/bloc/favourite_bloc.dart';
import '../models/conduitmodel.dart';
import '../repo/repository.dart';
import '../widgets/conduitwidget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    getdata();
    context.read<FavouriteBloc>()..add(LoadingStartEvent());
    super.initState();
  }
  String? username;
void getdata()async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  username=prefs.getString('username');
  //print(username);

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Column(
          children: [
            Text(
              "Favorite Article",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteErrorState) {
            final geterror = state as FavouriteErrorState;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text('${geterror.error}')));
          }
          if (state is FavouriteNoInternetState) {
            final net = state as FavouriteNoInternetState;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2), content: Text('${net.net}')));
          }
        },
        builder: (context, state) {
          if (state is FavouriteLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavouriteNoInternetState) {
            return Center(
              child: InkWell(
                  onTap: () {
                    context.read<FavouriteBloc>()..add(LoadingStartEvent());
                  },
                  child: Text("please try again..")),
            );
          }
          if (state is FavouriteLoadedState) {
            final load = state as FavouriteLoadedState;
            List<AllArticlesModel> favouritelist = load.favouritedata;
            if (load.favouritedata.isEmpty) {
              return Center(child: Text("no data"));
            } else {
              return ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ConduitWidget(
                      article: favouritelist[index],
                      articlerepo: ArticleRepository(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      width: 16,
                    );
                  },
                  itemCount: favouritelist.length);
            }
          }
          return Container(
            child: Center(child: Text("No data")),
          );
        },
      ),
    );
  }
}
