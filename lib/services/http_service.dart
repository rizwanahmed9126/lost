import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_tracking/constant/enum.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '/utils/service_locator.dart';

import '../services/storage_service.dart';

class HttpService {
  Dio _dio = Dio(); //builtin
  StorageService? storage = locator<StorageService>();
  final baseUrl = "https://big-unison-321920.firebaseapp.com/lost/api/v1/";

  Future<Dio> getApiClient() async {
    try {
      var token = await storage!.getData(StorageKeys.token.toString());
      _dio.interceptors.clear();
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, interceptorHandler) {
            // Do something before request is sent
            options.headers["Authorization"] = "Bearer " + token.toString();
            return interceptorHandler.next(options);
            // ignore: non_constant_identifier_names
          },
          onResponse: (response, interceptorHandler) {
            // Do something with response data
            return interceptorHandler.next(response); // continue
            // ignore: non_constant_identifier_names
          },
          onError: (error, interceptorHandler) async {
            // Do something with response error
            if (error.response?.statusCode == 403 ||
                error.response?.statusCode == 401) {
              _dio.interceptors.requestLock.lock();
              _dio.interceptors.responseLock.lock();
              // ignore: unused_local_variable
              RequestOptions options = error.response!.requestOptions;
              // ignore: unused_local_variable
              Options? opt;
              var user = FirebaseAuth.instance.currentUser!;
              token = await user.getIdToken(true);
              await storage!.setData("token", StorageKeys.token.toString());
              options.headers["Authorization"] = "Bearer " + token.toString();

              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();
              //  return _dio.request(options.path, options: opt);
            } else {
              return interceptorHandler.next(error);
            }
          },
        ),
      );
      // _dio.options.baseUrl = baseUrl;
    } catch (err) {
      print(err);
    }

    return _dio;
  }

  signUp(Map<String, dynamic> data, String userId) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + "users/signup", data: data, queryParameters: {"userId": userId});
    return response;
  }

  signIn() async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'users/signin');
    return response;
  }

  updateProfileInformation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response =
        await http.post(baseUrl + "users/profileinformation", data: data);
    return response;
  }

  editProfileInformation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + "users/updateuser", data: data);
    return response;
  }

  getUser() async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseUrl + "users/getuser");
      return response;
    } catch (er) {
      // print(er.toString());
    }
  }

  getUserById(String? userId) async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseUrl + "users/getuserbyid",
          queryParameters: {"userId": userId});
      return response;
    } catch (er) {
      // print(er.toString());
    }
  }

  registerDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response =
        await http.post(baseUrl + 'users/registerdevice', data: data);
    return response;
  }

  unRegisterDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response =
        await http.post(baseUrl + "users/unregisterdevice", data: data);
    return response;
  }

  // helpInformation(Map<String, dynamic> data) async {
  //   var http = await getApiClient();
  //   var response = await http.post(baseUrl + 'medicalinfo/add', data: data);
  //   return response;
  // }

// QUERY PARAMETER INCLUDE
  getAllPost(int count, int page) async {
    var http = await getApiClient();
    var response = await http.get(baseUrl + 'post/allposts',
        queryParameters: {"count": count, "page": page});

    return response;
  }

  responseNotification(notificationId, reactionType) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + "reaction/match/$reactionType",
        queryParameters: {"notificationId": notificationId});
    return response;
  }

  // QUERY PARAMETER INCLUDE
  getCurrentSession(String? userId) async {
    var http = await getApiClient();

    var response = await http.get(baseUrl + 'session/getSessionsByUserId',
        queryParameters: {"userId": userId});
    return response;
  }

  previousSession(String? userId) async {
    var http = await getApiClient();
    var response = await http.get(
        baseUrl + 'session/getPreviousSessionsByUserId',
        queryParameters: {'userId': userId});
    return response;
  }

  deleteUser(String? userId) async {
    var http = await getApiClient();

    var response = await http
        .post(baseUrl + "users/delete", queryParameters: {'userId': userId});
    return response;
  }

  deleteChats(String? chatId) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'users/deletechats',
        queryParameters: {"chatId": chatId});
    return response;
  }

  addNewSession(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'session/add', data: data);
    return response;
  }

  markAsPremium(Map<String, dynamic> data, String? userId) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + "users/premium",
        data: data, queryParameters: {'userId': userId});
    return response;
  }

  updateSessionStatus(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'session/update', data: data);
    return response;
  }

  addUserContact(Map<String, dynamic> data, String? userId) async {
    var http = await getApiClient();
    var response = await http
        .post(baseUrl + 'users/addcontact', data: data, queryParameters: {
      'userId': userId,
    });
    return response;
  }

  getAllUserContacts(String? userId) async {
    var http = await getApiClient();
    var response =
        await http.get(baseUrl + 'users/allcontacts', queryParameters: {
      'userId': userId,
    });
    return response;
  }
}
