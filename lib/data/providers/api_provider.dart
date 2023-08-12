// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:login_screen_homework/data/models/map/map_model.dart';
import '../network/repositories/repository.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> _addresses = [];
  bool _savedAddressCondition = false;

  List<Address> get addresses => _addresses;
  bool get savedAddressCondition => _savedAddressCondition;

  AddressProvider() {
    _initializeDatabaseAndLoadAddresses();
  }

  Future<void> _initializeDatabaseAndLoadAddresses() async {
    await DatabaseHelper.initializeDatabase();
    await loadAddresses();
  }

  Future<void> loadAddresses() async {
    _addresses = await DatabaseHelper.getAddresses();
    _savedAddressCondition = _addresses.isNotEmpty;
    notifyListeners();
  }

  Future<void> addAddress(Address address) async {
    await DatabaseHelper.insertAddress(address);
    await loadAddresses();
  }

  Future<void> deleteAddress(int index) async {
    final addressToDelete = _addresses[index];
    await DatabaseHelper.deleteAddress(addressToDelete.id);
    await loadAddresses();
  }

  Future<void> deleteAllAddresses() async {
    await DatabaseHelper.deleteAllAddresses();
    await loadAddresses();
  }
}
