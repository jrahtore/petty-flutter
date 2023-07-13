import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MatchesContainer extends StatelessWidget {
  dynamic snapshot;
  int index;
  MatchesContainer(this.index, this.snapshot, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 78),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(snapshot.data[index].image),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: Text(
                  snapshot.data[index].name,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  snapshot.data[index].occupation ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
              ),
              Positioned(
                bottom: 32,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white12,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/locationsvg.svg',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        snapshot.data[index].distance,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "myfonts",
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
