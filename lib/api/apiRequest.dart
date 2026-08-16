import 'dart:convert';

import 'package:e_commerce/api/details.dart';
import 'package:http/http.dart' as http;

import 'lists.dart';

const Map<String, String> _rapidApiHeaders = {
  'X-RapidAPI-Key': '91d5486736msh4da31749cd7f79ap1ec77ejsne9a732c8faea',
  'X-RapidAPI-Host': 'asos2.p.rapidapi.com',
};

class Api {
  Future<Lists> ApiData(int category) async {
    final response = await http.get(
        Uri.https("asos2.p.rapidapi.com", "/products/v2/list", {
          "store": 'US',
          "offset": '0',
          "categoryId": '$category',
          "limit": '48',
          "country": 'US',
          "sort": 'freshness',
          "currency": 'USD',
          "sizeSchema": 'US',
          "lang": 'en-US'
        }),
        headers: _rapidApiHeaders);
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Lists lists = Lists.fromMap(body);
      return lists;
    } else {
      throw ('failed ${response.body}');
    }
  }
}

class ApiInfo {
  Future<Details> ApiDetails(int id) async {
    final response = await http.get(
        Uri.https("asos2.p.rapidapi.com", "/products/v3/detail", {
          "id": '$id',
          "lang": 'en-US',
          "store": 'US',
          "sizeSchema": 'US',
          "currency": 'USD'
        }),
        headers: _rapidApiHeaders);
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Details details = Details.FromMap(body);
      return details;
    } else {
      throw ('failed ${response.body}');
    }
  }
}
