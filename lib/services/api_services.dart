import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/material.dart';

class Api {
  static String baseUrl = 'https://api.github.com/users';
  static String gitToken ='your-token';
  final di.Dio _dio = di.Dio(
    di.BaseOptions(
      baseUrl: baseUrl,
      headers: {'Accept': 'application/json','Authorization': 'token $gitToken'},
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout:const Duration(milliseconds: 15000),
      sendTimeout:const Duration(milliseconds: 15000),
    ),
  );

  Api() {
    //Exception handler
    _dio.interceptors.add(di.InterceptorsWrapper(onRequest: (options, handler) {
      log('REQUEST[${options.data}] => PATH: ${options.path}', name: "Dio");
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response); // continue
    }, onError: (di.DioException err, di.ErrorInterceptorHandler handler) {
      log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
          name: "Dio");
      if (err.response?.statusCode != null) {
        switch (err.response!.statusCode) {
          case 422:
            //send text error from back-end and show in front
            String message = err.response!.data['errors'].values;

            showDialog<bool>(
                context: Get.context!,
                builder: (ctx) => AlertDialog(
                      title: const Text("Warning"),
                      content:  Text(message),
                    ));
            break;
          case 500:
            //response from back-end error
            // This error occurs when the back-end crashes or the database crashes
            Get.snackbar("Error ${err.response?.statusCode ?? ""}",
                "server error,we trying to fix it",
                icon: const Icon(Icons.warning));
            break;
          case 401:
            //user not authentication OR The token is invalid
            // must be logout from application
            Get.snackbar('Token expired',"your token expired please login again",
                icon: const Icon(Icons.warning));
            String routePage = Get.currentRoute;
            if (routePage != "") {
              if (!routePage.contains("auth")) {
              //handle auth routing
              }
            } else {
              Future.delayed(Duration.zero, () {
                //navigate to login screen
              });
            }

            break;
          case 403:
            //permission error
            Get.snackbar("Error ${err.response?.statusCode ?? ""}",
                "something happened please try again ",
                icon: const Icon(Icons.warning));
            break;
          case 408:
            Get.snackbar("Error ${err.response?.statusCode ?? ""}",
                "please check your connection",
                icon: const Icon(Icons.warning));
            break;
          case 429:
            //too many request
            Get.snackbar("Error ${err.response?.statusCode ?? ""}",
                "something happened please try again ",
                icon: const Icon(Icons.warning));
            break;
          case 413:
            //too large request
            // Usually for send file from request
            Get.snackbar("Error ${err.response?.statusCode ?? ""}",
                "something happened please try again ",
                icon: const Icon(Icons.warning));
            break;
          case 502:
            //bad gateway
            // Usually the error is from nginx
            Get.snackbar(
                "Error ${err.response?.statusCode ?? ""}",
                "something happened please try again ",
                icon: const Icon(Icons.warning));
            break;
          default:
            Get.snackbar(
                "Error ${err.response?.statusCode ?? ""}",
                "something happened please try again ",
                icon: const Icon(Icons.warning));
            break;
        }
      }
      else {
        switch (err.type) {
          case di.DioExceptionType.connectionTimeout:
            Get.snackbar('Timeout at connecting', 'please check your connection',
                icon: const Icon(Icons.warning));
            break;
          case di.DioExceptionType.sendTimeout:
            Get.snackbar('Timeout error at sending data', 'please check your connection',
                icon: const Icon(Icons.warning));
            break;
          case di.DioExceptionType.receiveTimeout:
            Get.snackbar('Timeout error while receiving data', 'please check your connection',
                icon: const Icon(Icons.warning));
            break;
          case di.DioExceptionType.connectionError:
            Get.snackbar('No Internet Connection', 'please check your connection');
            break;
          case di.DioExceptionType.cancel:
            Get.snackbar('Canceled operation', 'operation have been canceled');
            break;
          case di.DioExceptionType.unknown:
            Get.snackbar('No Internet Connection', 'please check your connection');
            break;
          case di.DioExceptionType.badCertificate:
            Get.snackbar('Bad Certificate', 'The certificate is invalid.');
            break;
          case di.DioExceptionType.badResponse:
            Get.snackbar('Bad Response', 'Error happened in getting response');
        }
      }

      return handler.next(err);
    }));
  }

  //Get user list from api
  Future<di.Response> getUsers(int page, int perPage) async {
    return await _dio.get('$baseUrl?since=${(page - 1) * perPage}&per_page=$perPage',
    );
  }

}
