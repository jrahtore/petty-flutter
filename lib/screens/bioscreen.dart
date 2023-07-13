import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../api/report_user_api.dart';
import 'bottom_navigation/chat_detail.dart';

const kMainHeadingStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);
const kSubHeadingStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey,
);
const kSmallHeadingStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const kContentStyle = TextStyle(
  fontSize: 14,
  color: Colors.grey,
);

const kRedButtonStyle = TextStyle(
  fontSize: 18,
  color: Color(0xffce5d7e),
);

const kBlackButtonStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

final TextStyle _textStyle = const TextStyle(
  fontSize: 20,
);

final TextEditingController _additionalDetailsController =
    TextEditingController();

bool isLoading = false;

int dropDownValue = 0;

class BioScreen extends StatelessWidget {
  final String image, age, occupation, about, hobbies, name, userId;
  final VoidCallback onPressed;

  const BioScreen(
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
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: size.height / 2.1,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Container(
                height: size.height / 2.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          shadowLightColor: Colors.transparent,
                          shadowDarkColor: Colors.black,
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: 3,
                          lightSource: LightSource.topLeft,
                          color: Colors.white),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: -3,
                              intensity: 5,
                              lightSource: LightSource.topLeft,
                              shadowDarkColorEmboss: Colors.black,
                              color: Colors.black),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                  'assets/images/pettysvg_white.svg'),
                            ),
                            radius: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name, $age',
                      style: kMainHeadingStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${occupation ?? ''}',
                      style: kSubHeadingStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Text('About', style: kSmallHeadingStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Text('$about', style: kContentStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Hobbies', style: kSmallHeadingStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Text('$hobbies', style: kContentStyle),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          Divider(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                                'Share ${name.split(' ').last ?? name}\'s Profile',
                                style: kRedButtonStyle),
                          ),
                          Divider(),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setModalState) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Title',
                                                  style: _textStyle,
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                DropdownButton(
                                                    items: reportTitleList
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              child: Text(e),
                                                              value:
                                                                  reportTitleList
                                                                      .indexOf(
                                                                          e),
                                                              //value argument is required if more than one item
                                                            ))
                                                        .toList(),
                                                    value: dropDownValue,
                                                    onChanged: (value) {
                                                      dropDownValue = value;
                                                      setModalState(() {
                                                        dropDownValue;
                                                      });
                                                    }),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'Additional details',
                                              style: _textStyle,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextField(
                                              maxLines: 5,
                                              minLines: 3,
                                              controller:
                                                  _additionalDetailsController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Additional details',
                                                  border: OutlineInputBorder()),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (!isLoading) {
                                                    isLoading = true;
                                                    String message =
                                                        reportTitleList[
                                                                dropDownValue] +
                                                            ' --> ' +
                                                            _additionalDetailsController
                                                                .text;
                                                    bool isSuccess =
                                                        await ReportUserApi()
                                                            .postReport(userId,
                                                                message);
                                                    isLoading = false;
                                                    if (isSuccess) {
                                                      _additionalDetailsController
                                                          .clear();
                                                      Get.back();
                                                    }
                                                    isSuccess
                                                        ? Get.snackbar(
                                                            "Success",
                                                            'Report user success',
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2))
                                                        : Get.snackbar("Failed",
                                                            'Something went wrong. Try again',
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                  }
                                                },
                                                child: Text(
                                                  'SUBMIT',
                                                  style: _textStyle,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text('Report', style: kBlackButtonStyle),
                          ),
                          Divider(),
                          TextButton(
                            onPressed: onPressed,
                            child: Text('Block', style: kBlackButtonStyle),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
