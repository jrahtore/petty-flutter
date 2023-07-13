import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/sticker_api.dart';
import '../models/sticker_details_model.dart';
import '../models/stickers_model.dart';

class Stickers extends StatefulWidget {
  final String userId;
  final String friendsUserId;
  final bool isUserBlocked, amIBlocked;
  final CollectionReference messageSnapshots;
  const Stickers(
      {Key key,
      @required this.userId,
      @required this.friendsUserId,
      @required this.isUserBlocked,
      @required this.amIBlocked,
      @required this.messageSnapshots})
      : super(key: key);

  @override
  State<Stickers> createState() => _StickersState();
}

class _StickersState extends State<Stickers> {
  String categoryId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StickersApi().stickersGet(),
        builder: (BuildContext context, AsyncSnapshot<StickersModel> snapshot) {
          if (snapshot.hasData) {
            categoryId ??= snapshot.data?.data?.first?.id;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      children: snapshot.data.status == 'success' &&
                              snapshot.data != null
                          ? snapshot.data.data.map((e) {
                              return TextButton(
                                onPressed: () {
                                  setState(() {
                                    categoryId = e.id;
                                  });
                                },
                                child: Text(
                                  e.categoryName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: StickersApi().stickerDetailsGet(categoryId),
                          builder: (BuildContext context,
                              AsyncSnapshot<StickerDetailsModel> snapshot) {
                            if (snapshot.hasData) {
                              return GridView.count(
                                crossAxisCount: 4,
                                children: snapshot.data.data?.map(
                                      (e) {
                                        print(e.image);
                                        return InkWell(
                                          child: CachedNetworkImage(
                                            imageUrl: e.image,
                                          ),
                                          onTap: () {
                                            if (!widget.isUserBlocked &&
                                                !widget.amIBlocked) {
                                              widget.messageSnapshots.add({
                                                'image': e.image,
                                                'user': widget.userId,
                                                'time': FieldValue
                                                    .serverTimestamp(),
                                                'friend': widget.friendsUserId
                                              });
                                            }
                                          },
                                        );
                                      },
                                    )?.toList() ??
                                    [],
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Expanded(
              child: Center(
                child: Icon(Icons.image_not_supported_rounded),
              ),
            );
          } else {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
                

              ),
            );
          }
        });
  }
}
