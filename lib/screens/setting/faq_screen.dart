//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/models/cms.dart';

class FaqScreen extends StatefulWidget {
  final List data;
  FaqScreen({Key key, this.data}) : super(key: key);
  @override
  _FaqScreen createState() => _FaqScreen();
}

class _FaqScreen extends State<FaqScreen> {
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
            'FAQ',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: FaqDetails());
  }

  Widget FaqDetails() => ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.data[index].faqId}.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index].question,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.data[index].answer,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
