import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/gift_model.dart';
import '../screens/go_premium_pkgs.dart';

class GiftDialogBox extends StatefulWidget {
  GiftModel giftModel;
  GiftDialogBox(this.giftModel);
  @override
  _GiftDialogBoxState createState() => _GiftDialogBoxState();
}

class _GiftDialogBoxState extends State<GiftDialogBox> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.265,
        child: PageView.builder(
          itemCount: widget.giftModel.data?.length ?? 0,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) => Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GoPremiumPkgs(
                      discount: double.parse(widget
                          .giftModel.data[index].giftDescription
                          .split('%')[0]),
                    ),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.26,
                width: MediaQuery.of(context).size.width * 0.805,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        widget.giftModel?.data[index]?.imageName ?? ''),
                  ),
                ),
                padding: EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.giftModel.data[index]?.giftName ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          widget.giftModel.data[index]?.giftSpec ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 52,
                      left: 16,
                      child: FittedBox(
                        child: Text(
                          widget.giftModel.data[index]?.giftDescription ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
