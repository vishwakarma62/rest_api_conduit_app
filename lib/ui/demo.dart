import 'package:flutter/material.dart';
import 'package:rest_api_conduit_app/widgets/widget.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(itemBuilder: (context,index){
        return widgetpage();
      }, separatorBuilder: (context,index){
        return SizedBox(height: 20,);
      }, itemCount: 50),
    );
  }
}