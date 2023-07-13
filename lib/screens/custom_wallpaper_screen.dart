import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../api/chat_background_api.dart';
import '../models/chat_background_model.dart';

class CustomWallpaperScreen extends StatefulWidget {
  CustomWallpaperScreen({Key key}) : super(key: key);

  @override
  State<CustomWallpaperScreen> createState() => _CustomWallpaperScreenState();
}

class _CustomWallpaperScreenState extends State<CustomWallpaperScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isLoadingCompleted = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isAndroid ? false : true,
        title: Text(
          "Custom Wallpaper",
          style: TextStyle(
              color: Color(0xff1E2661),
              fontFamily: "SFUIDisplay",
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        iconTheme: IconThemeData(color: Color(0xff1E2661)),
        elevation: 1,
        backgroundColor: Colors.white,
        bottom: TabBar(
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffed417d),
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Tab(
                icon: SvgPicture.asset(
                  'assets/box.svg',
                  height: 20,
                  width: 20,
                  color: _tabController.index == 0
                      ? Color(0xffed417d)
                      : Color(0xffa9a9a9),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Tab(
                icon: SvgPicture.asset(
                  'assets/list.svg',
                  color: _tabController.index == 1
                      ? Color(0xffed417d)
                      : Color(0xffa9a9a9),
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
                child: Center(
                  child: FutureBuilder<ChatBackgroundModel>(
                    future: ChatBackgroundApi().chatBackgroundGet(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          !isLoadingCompleted) {
                        isLoadingCompleted = true;
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return GridView.custom(
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 12,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            pattern: [
                              QuiltedGridTile(6, 6),
                              QuiltedGridTile(6, 6),
                              QuiltedGridTile(5, 4),
                              QuiltedGridTile(5, 4),
                              QuiltedGridTile(5, 4),
                              // QuiltedGridTile(1, 1),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(
                                      context, snapshot.data.data[index].image);
                                },
                                child: Container(
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        image: new DecorationImage(
                                            image: new NetworkImage(snapshot
                                                .data.data[index].image),
                                            fit: BoxFit.cover))),
                              );
                            },
                            childCount: snapshot.data.data.length,
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 1, right: 1),
                child: Center(
                  child: FutureBuilder<ChatBackgroundModel>(
                    future: ChatBackgroundApi().chatBackgroundGet(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            itemCount: snapshot.data.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context,
                                          snapshot.data.data[index].image);
                                    },
                                    child: Container(
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            image: new DecorationImage(
                                                image: new NetworkImage(snapshot
                                                    .data.data[index].image),
                                                fit: BoxFit.cover))),
                                  ));
                            });
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ],
            controller: _tabController,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, '');
                  },
                  child: Text('Reset Image'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
