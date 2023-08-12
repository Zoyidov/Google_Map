import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_screen_homework/data/models/universal_model.dart';
import 'package:login_screen_homework/data/network/service/api_service.dart';

class AddressCallProvider with ChangeNotifier {
  AddressCallProvider({required this.apiService});

  final ApiService apiService;

  String scrolledAddressText = '';
  String kind = "house";
  String lang = "uz_UZ";

  getAddressByLatLong({required LatLng latLng}) async {
    UniversalData universalData = await apiService.getAddress(
      latLng: latLng,
      kind: kind,
      lang: lang,
    );

    if (universalData.error.isEmpty) {
      scrolledAddressText = universalData.data as String;
    } else {
    }
    notifyListeners();
  }

  void updateKind(String newKind) {
    kind = newKind;
  }

  void updateLang(String newLang) {
    lang = newLang;
  }

  bool canSaveAddress() {
    if (scrolledAddressText.isEmpty) return false;
    if (scrolledAddressText == 'Noma\'lum Hudud') return false;

    return true;
  }
}