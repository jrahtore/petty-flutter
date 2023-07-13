//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:petty_app/models/cms.dart';

class CmsScreen extends StatefulWidget {
  final String type;
  final String content;
  final String caption;
  CmsScreen({Key key, this.type, this.content, this.caption}) : super(key: key);
  @override
  _CmsScreen createState() => _CmsScreen();
}

class _CmsScreen extends State<CmsScreen> {
  CmsRequestModel cmsRequestModel;
  bool isLoading = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.caption,
            style: TextStyle(fontSize: 24),
          ),
          actions: [],
        ),
        body: cmsDetails());
  }

  Widget cmsDetails() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Html(
            data: widget.content,
          ),
        ),
      );
}
