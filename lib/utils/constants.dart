const baseUrl = "https://geocode-maps.yandex.ru";
const String apiKey = "8219fdc8-4567-447b-a4d7-7daf4c9ee892";

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const List<String> kindList = [
  "house",
  "metro",
  "district",
  "street",
];

const List<String> langList = [
  "uz_UZ",
  "ru_RU",
  "en_GB",
  "tr_TR",
];
