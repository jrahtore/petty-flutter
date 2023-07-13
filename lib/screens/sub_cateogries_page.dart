import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/screens/constants.dart';
import 'package:petty_app/services/auth.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';
import '../utils/urls.dart';
import 'main_bottom_page.dart';

List<String> categories = [];

class SubCategory extends StatefulWidget {
  final List<String> categoryList;
  const SubCategory({Key key, this.categoryList}) : super(key: key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List<String> selectedCategoryList = [];

  @override
  void initState() {
    super.initState();
    categories = widget.categoryList;
    print('categories in subcategory = ${widget.categoryList}');
  }

  void setUpComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PettySharedPref.setIsLoggedIn(prefs, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        categories = [];
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      "assets/images/redcolorpetty.png",
                      scale: 3,
                    ),
                    Expanded(child: SizedBox()),
                    // Icon(
                    //   Icons.search,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset('assets/images/subcatorgycontent.svg',
                  width: MediaQuery.of(context).size.width / 1.5),
              // GridView.count(
              //     shrinkWrap: true,
              //     crossAxisCount: 3,
              //     scrollDirection: Axis.vertical,
              //     childAspectRatio: 1.3,
              //     crossAxisSpacing: 4.0,
              //     mainAxisSpacing: 8.0,
              //     children: List.generate(choices.length, (index) {
              //       return Center(
              //         child: SelectCard(choice: choices[index]),
              //       );
              //     })),
              SizedBox(
                height: 20,
              ),

              Container(
                child: MultiSelectChip(
                  //categoryList,
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      selectedCategoryList = selectedList;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 35.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedCategoryList.length > 1) {
                      bool isSuccess = false;
                      isSuccess = await postData(_MultiSelectChipState
                          .selectedChoicesId
                          .toSet()
                          .toList());
                      print(
                          'subcategories selected = ${_MultiSelectChipState.selectedChoicesId}');
                      if (isSuccess) {
                        await setUpComplete();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => MainBottomPage()),
                            (route) => false);
                      }
                    } else {
                      showToast(
                        "Select atleast 2 sub-category",
                      );
                    }

                    // // await _databaseService.deMarkFirstLogIn(false);
                    // await DatabaseService(uid: user.uid).deMarkFirstLogIn(true);
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context,
                    //     '/wrapper',
                    //     (context) =>
                    //         false
                    //     );
                  },
                  style: kNextButtonStyle,
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(pinkColor),
                            Color(0xffFF5F5D),
                          ],

                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          //transform: GradientRotation(0.7853982),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 3,
                          minHeight: 30.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Ready to Go",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SFUIDisplay",
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> postData(var selectedChoices) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<Map<String, dynamic>> listOfMapNestedObjects = [];

      for (var choice in selectedChoices) {
        Map<String, dynamic> mapNestedObjects = {};
        mapNestedObjects.putIfAbsent('id', () => choice);
        listOfMapNestedObjects.add(mapNestedObjects);
      }

      var jsonData = json.encode(listOfMapNestedObjects);

      print('selected choicss = $selectedChoices');
      Map<String, dynamic> queryparameters = {
        'user_subcat_ids': jsonData,
        'token': PettySharedPref.getAccessToken(prefs),
        'user_id': PettySharedPref.getUserId(prefs)
      };
      var url =
          Uri.https(baseUrl, '/pettyapp/api/SubCategory', queryparameters);
      final response = await http.post(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      if (response.statusCode == 200) {
        var items = json.decode(response.body)['status'] != null
            ? json.decode(response.body)['status']
            : [];
        return true;
      } else {
        print(json.decode(response.body)['message']);
        final snackBar = SnackBar(
            content: Text('Server is busy'),
            duration: const Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class MultiSelectChip extends StatefulWidget {
  // final Map<String,dynamic> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip({this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List categoryData = [];

  List categoryDataId = [];
  bool isSnackShown = false;
  static List<String> selectedChoicesId = [];

  void fetchData() async {
    print('categories = $categories');
    for (String i in categories) {
      print('i  = $i');
      try {
        var queryParameters = {'id': i};
        var url =
            Uri.https(baseUrl, '/pettyapp/api/SubCategory', queryParameters);
        final response = await http.get(url, headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        });
        if (response.statusCode == 200) {
          var items = json.decode(response.body)['data'] != null
              ? json.decode(response.body)['data']
              : [];
          print('subcategory = $items');
          setState(() {
            categoryData.addAll(items);
            categoryData.toSet().toList();
          });
        } else {
          if (!isSnackShown) {
            final snackBar = SnackBar(
                content: Text('Server is busy'),
                duration: const Duration(seconds: 1));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            isSnackShown = true;
          }
        }
      } catch (e) {}
    }
  }

  // List<String> categoryList = [
  //   "Alcohol",
  //   "Body Modification",
  //   "Biting Nails",
  //   "Sex",
  //   "Porn",
  //   "Excersice",
  //   "Food",
  //   "Drug",
  //   "Ability to adapt",
  //   "Armpits",
  //   "Commissions",
  //   "Expectations",
  //   "Bad breath",
  //   "Lice",
  //   "Cavities",
  //   "Missing teeth",
  //   "Rotten teeth",
  //   "Formal",
  //   "Cousal",
  //   "Sour",
  //   "Sweet",
  //   "Emotional",
  //   "Neutral",
  //   "Positive",
  //   "Negative",
  // ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    categoryData.forEach((data) {
      String catergoryName = data['sub_category_name'];

      String categoryId = data['id'];
      choices.add(Container(
        margin: EdgeInsets.only(left: 11.0, right: 11, top: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ChoiceChip(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),

          //avatar: SvgPicture.asset(categoryIcon),
          backgroundColor: Color(0xffE5E4EB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          selectedColor: Color(0xffFF5F5D),
          pressElevation: 0.0,
          label: Container(
            child: Text(
              catergoryName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SFUIDisplay",
                  fontSize: 16),
            ),
          ),
          selected: selectedChoices.contains(catergoryName),
          onSelected: (selected) {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => MatchedPage()
            //     //MatchedPage()
            //   ),
            // );
            setState(() {
              if (selectedChoices.length < 5) {
                selectedChoices.contains(catergoryName)
                    ? selectedChoices.remove(catergoryName)
                    : selectedChoices.add(catergoryName);
                selectedChoices.contains(catergoryName)
                    ? selectedChoicesId.add(categoryId)
                    : selectedChoicesId.remove(categoryId);
                widget.onSelectionChanged(selectedChoices);
              } else {
                showToast(
                  "you can select any 5 sub catogries",
                  // context: context,
                  // alignment: Alignment.center,
                );
                setState(() {
                  selectedChoices.remove(catergoryName);
                  selectedChoicesId.remove(categoryId);
                  widget.onSelectionChanged(selectedChoices);
                });
              }
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceAround,
        runSpacing: 10,
        spacing: 15,
        children: _buildChoiceList(),
      ),
    );
  }
}

// class Choice {
//   const Choice({this.title});
//
//   final String title;
// }
//
// class SelectCard extends StatelessWidget {
//   const SelectCard({Key key, this.choice}) : super(key: key);
//   final Choice choice;
//
//   @override
//   Widget build(BuildContext context) {
//     final TextStyle textStyle = Theme.of(context).textTheme.display1;
//     return Card(
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Color(0xff707070), width: 1),
//       ),
//       child: Center(
//         child:
//             // Expanded(
//             //     child:
//             //         Icon(choice.icon, size: 50.0, color: textStyle.color)),
//             Text(
//           choice.title,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               color: Color(0xff1E2661),
//               fontFamily: "SFUIDisplay",
//               fontWeight: FontWeight.bold,
//               fontSize: 18),
//         ),
//         // Text(choice.title,
//         //   textAlign: TextAlign.center,
//         //   style: textStyle,
//         // ),
//       ),
//     );
//   }
// }
