import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc_delegate.dart';
import 'data/endpoint.dart';
import 'main.dart';
import 'util/app_util.dart';

class App {
  final String apiBaseURL;
  final String appTitle;
  static App _instance;
  Dio dio;

  App.configure(
      {this.apiBaseURL, this.appTitle, this.dio, this.sharedPreferences}) {
    _instance = this;
  }

  SharedPreferences sharedPreferences;

  factory App() {
    if (_instance == null) {
      throw UnimplementedError('App must be configured first.');
    }

    return _instance;
  }

  Future<Null> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // configure bloc delegate
    BlocSupervisor.delegate = SimpleBlocDelegate();

    dio = Dio(BaseOptions(
        baseUrl: apiBaseURL,
        receiveDataWhenStatusError: true,
        connectTimeout: 15 * 1000,
        receiveTimeout: 15 * 1000,
        responseType: ResponseType.json));
    setDioInterceptor();
  }

  void setDioInterceptor() {
    dio.interceptors
        .add(InterceptorsWrapper(onError: (DioError e, handler) async {
      Map<String, dynamic> data = e?.response?.data;
      if (e?.response?.statusCode != null) {
        switch (e?.response?.statusCode) {
          case 400:
            AppUtil.showToast(data['message']);
            break;
          case 401:
            AppUtil.showToast(data['message']);
            break;
          case 403:
            AppUtil.showToast(data['message']);
            break;
          case 404:
            AppUtil.showToast(data['message']);
            break;
          case 500:
            AppUtil.showToast('Terjadi kesalahan di server');
            break;
        }
        return handler.next(e);
      }
      return handler.next(e);
    }));
  }
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  App.configure(apiBaseURL: Endpoint.baseURLProd, appTitle: 'Al-Hikmah App');

  await App().init();

  runApp(MyApp());
}
