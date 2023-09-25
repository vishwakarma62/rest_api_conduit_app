import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_conduit_app/blocs/createarticles/bloc/creat_article_bloc.dart';
import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:rest_api_conduit_app/ui/conduit_screen.dart';
import 'package:rest_api_conduit_app/ui/favourite.dart';

import 'drawer.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key, required this.index});
  var index;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  final List<Map<String, dynamic>> _Pagedetails = [
    {
      'pageName': const ConduitScreen(),
      'title': 'conduit',
      'subtitle': 'A place to share your knowledge'
    },
  ];
  // List<Map<String, dynamic>> colorlist = [
  //   {'color': Colors.red},
  //   {'color': Colors.green},
  //   {'color': Colors.greenAccent},
  //   {'color': Colors.orange},
  //   {'color': Colors.teal}
  // ];
  // List<Map<String, dynamic>> colorlist2 = [
  //   {'color': Colors.orange},
  //   {'color': Colors.greenAccent},
  //   {'color': Colors.green},
  //   {'color': Colors.red},
  //   {'color': Colors.primaries}
  // ];

  List<BottomNavigationBarItem> _buildFourItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.note_sharp),
        label: 'Global',
        backgroundColor: Colors.red,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Your Feed',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'Add',
        backgroundColor: Colors.green,
      ),
    ];
  }

  @override
  void initState() {
    setState(() {
      _selectedpageindex = widget.index;
    });
    super.initState();
  }

  List<String> list = [
    "HomePage",
    "album",
    "Post",
    "Photos",
    "User",
    "Conduit data"
  ];

  var _selectedpageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                tooltip: "favourite articles",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FavouriteScreen();
                  }));
                },
                icon: Icon(Icons.favorite_border)),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return UserForm();
                    },
                  );
                },
                icon: Icon(Icons.add)),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Column(
            children: [
              Text(
                _Pagedetails[_selectedpageindex]['title'],
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                _Pagedetails[_selectedpageindex]['subtitle'],
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
        ),
        body: _Pagedetails[_selectedpageindex]['pageName'],
        drawer: DrawerPage(),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.green,
            onTap: (value) {
              _selectedpageindex = value;
            },
            items: _buildFourItems()));
  }
}

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController titleCTR = TextEditingController();

  TextEditingController descriptionCTR = TextEditingController();

  TextEditingController bodyCTR = TextEditingController();
  TextEditingController listoneCtr = TextEditingController();
  TextEditingController listtwoCtr = TextEditingController();
  TextEditingController listthreeCtr = TextEditingController();
  TextEditingController listfourCtr = TextEditingController();

  List<String> datalist = [];

  void setdata() {
    if (listoneCtr.text.isEmpty ||
        listtwoCtr.text.isEmpty ||
        listthreeCtr.text.isEmpty ||
        listfourCtr.text.isEmpty) {
      setState(() {
    datalist=[];
      });
    } else {
      datalist.add(listoneCtr.text);
      datalist.add(listtwoCtr.text);
      datalist.add(listthreeCtr.text);
      datalist.add(listfourCtr.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Add Articles",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: titleCTR,
                    keyboardType: TextInputType.name,
                    maxLines: 2,
                    decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6)),
                        hintText: 'Enter title...........'),
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
                    controller: bodyCTR,
                    keyboardType: TextInputType.name,
                    maxLines: 4,
                    decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6)),
                        hintText: 'Enter body...........'),
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
                    controller: descriptionCTR,
                    keyboardType: TextInputType.name,
                    maxLines: 6,
                    decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6)),
                        hintText: 'Enter your description...........'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 85,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextFormField(
                          controller: listoneCtr,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)),
                              hintText: ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextFormField(
                          controller: listtwoCtr,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)),
                              hintText: ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextFormField(
                          controller: listthreeCtr,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)),
                              hintText: ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextFormField(
                          controller: listfourCtr,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)),
                              hintText: ''),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    print(titleCTR.text);
                    setdata();
                    context.read<CreatArticleBloc>()
                      ..add(
                        CreatArticleInitialEvent(
                          allArticlesModel: AllArticlesModel(
                              title: titleCTR.text,
                              body: bodyCTR.text,
                              description: descriptionCTR.text,
                              tagList: datalist),
                        ),
                      );

                    Navigator.of(context).pop();
                  // Close the bottom sheet
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 250,
        ),
      ],
    );
  }
}
