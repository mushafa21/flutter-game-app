

import 'dart:io';

import 'package:dio/dio.dart';

import '../firebase/firebase_send.dart';
import '../utils/config.dart';
import '../utils/helper.dart';


class ApiBaseHelper{
  final String _baseUrl = Config.baseApi;

  /** Global Headers */

  Map<String, String> headers = {
    "Content-type" : "application/json",
    "Accept" : "application/json",
  };

  /** Global Parameters */

  Map<String, dynamic> parameters = {
    "key": Config.apiKey,
  };

  Future<dynamic> get({required String url, Map<String, String>? extraHeader,  Map<String, dynamic>? parameter}) async {

    Options options = Options();
    options.headers = headers;

    if(parameter != null){
      parameters.addAll(parameter);
    }


    if(extraHeader != null){
      options.headers?.addAll(extraHeader);
    }

    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));



    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("parameter : " + parameters.toString());

      final response =  await dio.get(_baseUrl+ url,options: options,queryParameters: parameters, );
      responseJson = response.data;
    }on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");

        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
    }
    return responseJson;
  }

  Future<dynamic> post({required String url, Map<String, String>? extraHeader, Object? body,  Map<String, dynamic>? parameter}) async {
    Options options = Options();
    options.headers = headers;

    if(extraHeader != null){
      options.headers?.addAll(extraHeader);
    }

    if(parameter != null){
      parameters.addAll(parameter);
    }

    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));



    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("Parameter : " + parameters.toString());
      if(body != null){
        print("Body : " + body.toString());
      }

      final response =  await dio.post(_baseUrl+ url,data: body,options: options,queryParameters: parameters);
      responseJson = response.data;
    } on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");


        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
      throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";
    }
    return responseJson;
  }

  Future<dynamic> postFormData({required String url, required Map<String, dynamic> formData,Map<String, String>? extraHeader,  Map<String, dynamic>? parameter}) async {
    Options options = Options();
    options.headers = headers;

    if(parameter != null){
      parameters.addAll(parameter);
    }

    if(extraHeader != null){
      options.headers?.addAll(extraHeader);
    }
    FormData data = FormData.fromMap(formData);

    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));


    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("Parameter : " + parameters.toString());
      print("Body : " + formData.toString());

      final response =  await dio.post(_baseUrl + url, data: data, options: options,queryParameters: parameters);
      responseJson = response.data;
    } on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");


        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
      throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";

    }
    return responseJson;
  }

  Future<dynamic> upload({required String url, required File file,required String type,  Map<String, dynamic>? parameter}) async {
    Options options = Options();
    options.headers = headers;

    if(parameter != null){
      parameters.addAll(parameter);
    }

    String fileName = file.path
        .split('/')
        .last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));



    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("Parameter : " + parameters.toString());
      final response =  await dio.post(_baseUrl + url, data: data, options: options,queryParameters: parameters);
      responseJson = response.data;

    } on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");


        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
      throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";
    }
    return responseJson;
  }

  Future<dynamic> delete({required String url, Map<String, String>? extraHeader, Object? body,  Map<String, dynamic>? parameter}) async {
    Options options = Options();
    options.headers = headers;

    if(parameter != null){
      parameters.addAll(parameter);
    }

    if(extraHeader != null){
      options.headers?.addAll(extraHeader);
    }

    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));



    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("Parameter : " + parameters.toString());
      if(body != null){
        print("Body : " + body.toString());
      }
      final response =  await dio.delete(_baseUrl+ url,data: body,options: options,queryParameters: parameters);
      responseJson = response.data;
    } on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");


        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
      throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda atau coba beberapa saat lagi";
    }
    return responseJson;
  }

  Future<dynamic> put({required String url, Map<String, String>? extraHeader,  Map<String, dynamic>? parameter,Map<String, dynamic>? formData}) async {

    Options options = Options();
    options.headers = headers;

    if(parameter != null){
      parameters.addAll(parameter);
    }
    FormData? data;
    if(formData != null){
      data = FormData.fromMap(formData);
    }



    if(extraHeader != null){
      options.headers?.addAll(extraHeader);
    }

    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          Helper.prettyPrintJson(response.data);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));



    var responseJson;
    try {
      print(_baseUrl+ url);
      print("Header : " + headers.toString());
      print("Parameter : " + parameters.toString());
      if(formData != null){
        print("Body : " + formData.toString());
      }
      final response =  await dio.put(_baseUrl+ url,options: options,queryParameters: parameters ,data: data,);
      responseJson = response.data;
    }on DioError catch(e) {
      if (e.type == DioErrorType.response) {
        String error = "";
        try{
          final errorResponse = e.response?.data as Map<String,dynamic>;
          Helper.prettyPrintJson(errorResponse);
          error =  "Error ${e.response?.statusCode}, ${errorResponse["message"]}";
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");

        }catch(e2){
          FirebaseSend().send(lokasi: _baseUrl+ url, message: "code : ${e.response?.statusCode}. data : ${e.response?.data}. msg :${e.message}");
          error =  "Terjadi kesalahan, Error ${e.response?.statusCode}";
        }
        throw error;

      }
      if (e.type == DioErrorType.connectTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Connect Timeout");
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";
      }

      if (e.type == DioErrorType.receiveTimeout) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: "Receive Timeout");
        throw "Terjadi kesalahan. Silahkan tunggu beberapa saat lagi";
      }

      if (e.type == DioErrorType.other) {
        FirebaseSend().send(lokasi: _baseUrl+ url, message: e.message);
        throw "Terjadi kesalahan. Silahkan periksa koneksi internet anda";}
    } catch (e) {
      FirebaseSend().send(lokasi: _baseUrl+ url, message: e.toString());
    }
    return responseJson;
  }



}