import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _TemplatePageState();
  }
}

class _TemplatePageState extends State<TemplatePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Template")),
    );
  }
}