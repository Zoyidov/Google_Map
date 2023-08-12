import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_screen_homework/data/models/geocoding/geocoding.dart';
import 'package:login_screen_homework/data/models/universal_model.dart';
import 'package:login_screen_homework/utils/constants.dart';

class ApiService {
  // DIO SETTINGS

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '8219fdc8-4567-447b-a4d7-7daf4c9ee892',
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> getAddress({
    required LatLng latLng,
    required String kind,
    required String lang,
  }) async {
    Response response;
    try {
      response = await dio.get(
        '/1.x/',
        queryParameters: {
          "apikey": apiKey,
          "geocode": "${latLng.longitude}, ${latLng.latitude}",
          "lang": lang,
          "format": "json",
          "kind": kind,
          "rspn": "1",
          "results": "1",
        },
      );

      if (response.statusCode == 200) {
        String text = 'Noma\'lum Hudud';
        Geocoding geocoding = Geocoding.fromJson(response.data);
        if (geocoding.response.geoObjectCollection.featureMember.isNotEmpty) {
          text = geocoding.response.geoObjectCollection.featureMember[0]
              .geoObject.metaDataProperty.geocoderMetaData.text;
        }
        return UniversalData(data: text);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}