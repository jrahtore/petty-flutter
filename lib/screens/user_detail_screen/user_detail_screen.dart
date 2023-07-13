import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/widgets/bold_text.dart';
import '../../contants/constants.dart';
import '../../widgets/alert_dialogue.dart';
import '../../widgets/text_button.dart';

class UserDetailsScreen extends StatelessWidget {
  final String image, age, occupation, about, hobbies, name, userId;
  final VoidCallback onPressed;
  const UserDetailsScreen(
      {Key key,
      this.image =
          'https://cdn.pixabay.com/photo/2022/05/18/12/04/flower-7205105__340.jpg',
      this.age = '45',
      this.occupation = 'Founder at Petty Chat',
      this.about =
          'Great father, visionary, time traveller, bathroom mirror model'
              'social engineer. I love to treat people with kindness',
      this.hobbies =
          'App development, sports, petty sh*t, house building, basketball',
      this.name = 'Petty King',
      this.userId,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height - 350,
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    image: DecorationImage(
                       image: CachedNetworkImageProvider(image),
                      // image: AssetImage(
                      //   'assets/images/jerricpng.png',
                      // ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(240),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 350,
                  left: 270,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        // color: Color(0xffe4547f),
                        color: Colors.pink,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black45,
                              spreadRadius: 2),
                        ],
                      ),
                      // backgroundColor: Colors.pink,
                      // radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/petyheart.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text( '$name, $age',
                      style: kMainHeadingStyle,),
                  // BoldText(
                  //   txt: 'Ashlynn Brenna, 27',
                  //   clr: Colors.black,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${occupation ?? ''}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('About', style: kSmallHeadingStyle),
                  SizedBox(
                    height: 5,
                  ),
                    Text('$about', style: kContentStyle),
                  // Text(
                  //   'In publishing and graphic design, Lorem ipsum demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                  //Text('Aboutt', style: kContentStyle),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  // Text(
                  //   'Occupation',
                  //    style: kSmallHeadingStyle,
                  //   // style: TextStyle(
                  //   //   fontWeight: FontWeight.bold,
                  //   //   fontSize: 18,
                  //   //   fontFamily: 'SFUIDisplay',
                  //   // ),
                  // ),
                  // Text(
                  //   '${occupation ?? ''}',
                  //   style: kSubHeadingStyle,
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  //
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Divider(
                  //   thickness: 1,
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text('Hobbies', style: kSmallHeadingStyle),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  //  Text('$hobbies', style: kContentStyle),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Hobbies',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'SFUIDisplay',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('$hobbies', style: kContentStyle),
                  // Text(
                  //   'In publishing and graphic design, Lorem ipsum demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Column(
                    children: [
                      CustomTextButton(
                        txt: 'Shares Alysynn\'s Profile',
                        clr: Colors.pink,
                        onprs: () {},
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      CustomTextButton(
                        txt: 'Report',
                        clr: Colors.black54,
                        onprs: () {
                          showAlertDialog(
                            context,
                          );
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      CustomTextButton(
                        txt: 'Block',
                        clr: Colors.black54,
                        onprs: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
