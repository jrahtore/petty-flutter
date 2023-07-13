import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category_items.dart';
import '../utils/urls.dart';

class FetchCategoryList {
  Future<List> fetchCategoryData(context) async {
    try {
      var url = Uri.https(baseUrl, '/pettyapp/api/Category');
      final response = await http.get(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      CategoryItems categoryItems =
          CategoryItems.fromJson(json.decode(response.body)) ?? [];
      if (response.statusCode == 200) {
       
        List items = categoryItems.data;
        return items;
      } else {
        final snackBar = SnackBar(
            content: Text(categoryItems.message),
            duration: const Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
