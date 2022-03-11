import 'dart:convert';
import 'package:examui/models/banks_model.dart';
import 'package:http/http.dart';

import 'log_service.dart';



class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "622ac25514ccb950d2248697.mockapi.io";
  static String SERVER_PRODUCTION = "622ac25514ccb950d2248697.mockapi.io";

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    //Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  /* Http Apis */
  static String API_LIST = "/banks";
  static String API_CREATE = "/banks";
  static String API_UPDATE = "/banks"; //{id}
  static String API_DELETE = "/banks"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Banks banks) {
    Map<String, String> params ={};
    params.addAll({
      "cardNumber" : banks.cardNumber.toString(),
      "expiredDate" : banks.expiredDate.toString(),
      "cvvCode" : banks.cvvCode.toString(),
      "cardHolderName" : banks.cardHolderName.toString(),
      "id" : banks.id.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Banks banks) {
    Map<String, String> params ={};
    params.addAll({

    });
    return params;
  }

  /* Http Parsing */

  static List<Banks> parsePostList(String body) {
    List<Banks> posts = banksFromJson(body);
    return posts;
  }
}

