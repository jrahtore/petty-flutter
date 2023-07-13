import 'package:flutter/material.dart';
import 'package:petty_app/api/match_list_api.dart';
import 'package:petty_app/models/match_list_response.dart';
import 'package:petty_app/utils/constant.dart';

class MatchesListPage extends StatefulWidget {
  const MatchesListPage({Key key}) : super(key: key);

  @override
  _MatchesListPageState createState() => _MatchesListPageState();
}

class _MatchesListPageState extends State<MatchesListPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Petty People",
                style: TextStyle(
                    color: Color(0xff1E2661),
                    fontFamily: "SFUIDisplay",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      value;
                    });
                  },
                  cursorColor: Colors.grey,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(greyColor), width: 1.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(greyColor), width: 1.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(pinkColor),
                        size: 20,
                      ),
                      hintText: "Search...",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder<List<Message>>(
                    future: MatchListApiService().fetchMatchList(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(
                            "No matches found !",
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (_controller != null &&
                                  _controller.text.isNotEmpty) {
                                if (snapshot.data[index].name
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase())) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Container(
                                                  height: 80,
                                                  child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data[index]
                                                              .image)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data[index].name,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  snapshot.data[index]
                                                              .occupation ==
                                                          null
                                                      ? SizedBox()
                                                      : Text(
                                                          snapshot.data[index]
                                                              .occupation,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                                color: Colors.red,
                                              ),
                                              child: Text(
                                                snapshot.data[index].distance,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                    ],
                                  );
                                }
                                return null;
                              } else {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                height: 80,
                                                child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                            .data[index]
                                                            .image)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[index].name,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                snapshot.data[index]
                                                            .occupation ==
                                                        null
                                                    ? SizedBox()
                                                    : Text(
                                                        snapshot.data[index]
                                                            .occupation,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              color: Colors.red,
                                            ),
                                            child: Text(
                                              snapshot.data[index].distance,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )))
                                  ],
                                );
                              }
                            });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
