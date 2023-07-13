import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/api/fetch_category_data.dart';
import 'package:petty_app/models/category_items.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth.dart';
import '../../utils/petty_shared_pref.dart';
import '../../utils/urls.dart';
import '../constants.dart';
import '../go_premium_pkgs.dart';
import '../sub_cateogries_page.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Data> selectedCategoryList = [];

  updateSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> nameList = [];
    for (Data data in selectedCategoryList) {
      nameList.add(data.categoryName);
    }
    PettySharedPref.setSelectedSubcategoryList(prefs, nameList);
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
      Map<String, dynamic> queryparameters = {
        'user_cat_selections': jsonData,
        'token': PettySharedPref.getAccessToken(prefs),
        'user_id': PettySharedPref.getUserId(prefs)
      };
      var url = Uri.https(baseUrl, '/pettyapp/api/Category', queryparameters);
      final response = await http.post(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      if (response.statusCode == 200) {
        var items = json.decode(response.body) != null
            ? json.decode(response.body)
            : [];
        print('items updated in category page + $items');
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

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<MyUser>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Image.asset(
                        "assets/images/redcolorpetty.png",
                        scale: 3,
                      ),

                      SizedBox(
                        height: 1,
                      ),
                      // Icon(
                      //   Icons.search,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Select any ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: '1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              fontSize: 18)),
                      TextSpan(
                          text: ' to', style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: ' 5 categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              fontSize: 18)),
                      TextSpan(
                          text: ' you are',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      TextSpan(
                          text: ' Petty ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              fontSize: 18)),
                      TextSpan(
                        text: ' about',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: (MediaQuery.of(context).size.width -
              //               MediaQuery.of(context).size.width / 1.5) /
              //           2,
              //       right: (MediaQuery.of(context).size.width -
              //               MediaQuery.of(context).size.width / 1.5) /
              //           2),
              //   child: Text(
              //     "Select all the category that you have Petty things about below",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: Color(0xffBFBFBF),
              //         fontFamily: "SFUIDisplay",
              //         fontSize: 15),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 10),
              Container(
             
                margin: EdgeInsets.only(left: 20, right: 20),
                child: MultiSelectChip(
                  //categoryList,
                  onSelectionChanged: (selectedList) {
                    selectedCategoryList = selectedList;
                    for (Data data in selectedList) {
                      print(data.categoryName);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
//================ NEXT BUTTON ==============//
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedCategoryList.length > 0) {
                          bool isSuccess = false;
                          List<String> idList = [];
                          for (Data data in selectedCategoryList) {
                            idList.add(data.id);
                          }
                          isSuccess = await postData(idList);
                          if (isSuccess) {
                            await updateSharedPref();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategory(
                                        categoryList: idList,
                                      )

                                  //MainBottomPage(),
                                  //welcomepage
                                  ),
                            );
                          }
                        } else {
                          showToast(
                            "Select atleast 1 category",
                          );
                        }
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
                            "Next",
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
              SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip from being Petty',
                    style: TextStyle(color: Colors.grey),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  // final Map<String,dynamic> reportList;
  final Function(List<Data>) onSelectionChanged;

  MultiSelectChip({this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<Data> categoryData = [];
  List<Data> selectedChoices = [];
  // static List<String> selectedChoicesId = [];
  // static List<String> selectedChoicesName = [];

  // Future<CategoryItem> _itemData;
  @override
  void initState() {
    super.initState();
    fetchCategoryList();

    // GetItems items = GetItems();
    // _itemData = items.getCategory();
  }

  Future<void> fetchCategoryList() async {
    categoryData = await FetchCategoryList().fetchCategoryData(context);
    setState(() {
      categoryData;
    });
  }

  _buildChoiceList() {
    List<Widget> choices = [];

    categoryData.forEach((data) {
      choices.add(Container(
        width: data.categoryName == 'Super Petty'
            ? MediaQuery.of(context).size.width / 1.1
            : null,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ChoiceChip(
          elevation: data.categoryName == 'Super Petty' ? 5 : 0,
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),
          avatar: SvgPicture.network(data.image),
          backgroundColor: Color(0xffE5E4EB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          selectedColor: Color(0xffFF5F5D),
          pressElevation: 0.0,
          label: Container(
            child: Text(
              data.categoryName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SFUIDisplay",
                  fontSize: 16),
            ),
          ),
          selected: selectedChoices.contains(data),
          onSelected: (selected) async {
            if (data.categoryName == 'Super Petty' &&
                selectedChoices.length < 5 &&
                selected) {
              var result;
              result = await getResultInPreferences();
              if (result != 0) {
                result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GoPremiumPkgs(
                      isFromCategory: true,
                    ),
                  ),
                );
                setResultInPreferences(result);
              }

              if (result == 0) {
                setState(() {
                  selectedChoices.add(data);
                });
                widget.onSelectionChanged(selectedChoices);
              }
            } else if (selectedChoices.length < 5 && selected) {
              setState(() {
                selectedChoices.add(data);
              });
              widget.onSelectionChanged(selectedChoices);
            } else if (!selected) {
              setState(() {
                if (data.categoryName != 'Super Petty') {
                  selectedChoices.remove(data);
                }
              });
              widget.onSelectionChanged(selectedChoices);
            } else {
              showToast(
                "you can only select maximum 5 categories",
              );
            }
          },
        ),
      ));
    });
    return choices;
  }

  setResultInPreferences(var result) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PettySharedPref.setIsPaidOnStart(sharedPreferences, result ?? 1);
  }

  getResultInPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return PettySharedPref.getIsPaidOnStart(sharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.end,
            runAlignment: WrapAlignment.spaceAround,
            runSpacing: 10,
            spacing: 15,
            children: _buildChoiceList(),
          ),
        ],
      ),
    );
  }
}
