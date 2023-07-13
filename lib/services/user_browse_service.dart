import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/api/slider_list_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/match_add_api.dart';
import '../models/match_add_model.dart';
import '../models/slider_list_response.dart';
import '../utils/petty_shared_pref.dart';
import '../utils/urls.dart';

class UserBrowseService {
  final _usersApi = SliderApiProvider();
  int pageNumber = 0;

  static final UserBrowseService _instance = UserBrowseService._internal();

  //Storage a queue or more precisely a reverse queue you can figure that on your own
  //Hint : reverse queue + stack ?
  final usersBrowsed = BehaviorSubject<List<SliderListResponse>>()
    ..distinctUnique();
  final List<SliderListResponse> usersRewind = [];

  //If you want to show loading status in case your queue is empty
  final browsedLoading = BehaviorSubject<bool>.seeded(false)..distinctUnique();
  UserBrowseService._internal();

  factory UserBrowseService() => _instance;

  Future<List<SliderListResponse>> browseMoreUsers() async {
    pageNumber++;
    List<SliderListResponse> browsedUsers =
        await _usersApi.getSlider(pageNumber);
    return browsedUsers;
  }

  Future<void> browseUsers() async {
    browsedLoading.add(true);
    List<SliderListResponse> users = await browseMoreUsers();
    _addMoreUsersToQueue(users);
    browsedLoading.add(false);
  }

  // Adds new browsed users -- duplicates allowed
  void _addMoreUsersToQueue(List<SliderListResponse> browsed) {
    List<SliderListResponse> usersInList =
        usersBrowsed.valueOrNull ?? <SliderListResponse>[];
    usersBrowsed.add(browsed + usersInList);
  }

  void _removeFromBrowsedUserByIndex(int swipedOn) {
    List<SliderListResponse> usersInList =
        usersBrowsed.valueOrNull ?? <SliderListResponse>[];

    usersRewind.add(usersInList[swipedOn]);

    usersInList.removeAt(swipedOn);
    usersBrowsed.add(usersInList);

    if (usersRewind.length > 10) {
      usersRewind.removeAt(0);
    }
  }

  Future<void> swipedLeft(int index, SliderListResponse user) async {
    assert(usersBrowsed.valueOrNull != null);
    _removeFromBrowsedUserByIndex(index);
    updateUserRemovedToDatabase(user.id);
    if (usersBrowsed.value.length < 5) {
      browseUsers();
    }
  }

  Future<void> rewindCard() async {
    if (usersRewind.isNotEmpty) {
      List<SliderListResponse> usersInList =
          usersBrowsed.valueOrNull ?? <SliderListResponse>[];
      usersInList.insert(usersInList.length, usersRewind.last);
      usersBrowsed.add(usersInList);
      usersRewind.removeLast();
    }
  }

  Future<void> swipedRight(int index, SliderListResponse user) async {
    assert(usersBrowsed.valueOrNull != null);

    _removeFromBrowsedUserByIndex(index);
    updateUserLikedToDatabase(user.id);
    if (usersBrowsed.value.length < 5) {
      browseUsers();
    }
  }

  Future<bool> updateUserRemovedToDatabase(var dislikedUserId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> queryparameters = {
        'token': PettySharedPref.getAccessToken(prefs),
        'user_id': PettySharedPref.getUserId(prefs),
        'dislike_id': dislikedUserId,
      };
      var url =
          Uri.https(baseUrl, '/pettyapp/api/dislike_store', queryparameters);
      final response = await http.post(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      if (response.statusCode == 200) {
        var items = json.decode(response.body) != null
            ? json.decode(response.body)
            : [];
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void updateUserLikedToDatabase(String id) async {
    // matchAddRequestModel.userLikeId = widget.user.id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MatchAddRequestModel matchAddRequestModel = MatchAddRequestModel(
        userId: PettySharedPref.getUserId(prefs),
        userLikeId: id,
        token: PettySharedPref.getAccessToken(prefs));

    MatchAdd matchAdd = new MatchAdd();
    matchAdd.matchadd(matchAddRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          print(value.message);
        } else {
          Get.snackbar(
            "ERROR",
            value.message,
            duration: const Duration(seconds: 1),
          );
        }
      }
    });
  }
}
