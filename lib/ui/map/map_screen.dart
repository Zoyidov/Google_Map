// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_screen_homework/data/providers/address_call_provider.dart';
import 'package:login_screen_homework/data/providers/api_provider.dart';
import 'package:login_screen_homework/ui/map/widget/current_address_field.dart';
import 'package:login_screen_homework/ui/map/widget/kind_of_address.dart';
import 'package:login_screen_homework/ui/map/widget/language_of_address.dart';
import 'package:login_screen_homework/ui/map/widget/save_address_button.dart';
import 'package:login_screen_homework/ui/map/widget/type_of_map.dart';
import 'package:login_screen_homework/utils/icons.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../saved_adresses/adress_list_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.latLong});

  final LatLng latLong;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapType _selectedMapType = MapType.normal;
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  late LatLng _selectedLocation;
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    Provider.of<AddressProvider>(context, listen: false).loadAddresses();
    _selectedLocation = widget.latLong;
    initialCameraPosition = CameraPosition(target: _selectedLocation, zoom: 15);
    currentCameraPosition = initialCameraPosition;
  }

  void _fetchAddress(LatLng location) async {
    final addressProvider = context.read<AddressCallProvider>();
    await addressProvider.getAddressByLatLong(latLng: location);
    setState(() {
      _selectedAddress = addressProvider.scrolledAddressText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.google,
                width: 100,
              ),
              SvgPicture.asset(
                AppImages.me,
                width: 30,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              compassEnabled: false,
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              mapType: _selectedMapType,
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {},
              onTap: (LatLng location) {
                setState(() {
                  currentCameraPosition = CameraPosition(
                      target: location, zoom: currentCameraPosition.zoom);
                  context.read<AddressCallProvider>().getAddressByLatLong(
                        latLng: currentCameraPosition.target,
                      );
                  _selectedLocation = location;
                });
                _fetchAddress(location);
              },
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 15,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: _selectedLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
              },
            ),
            _selectedAddress.isNotEmpty ? const CurrentAddressField() : const Text(''),
            Positioned(
              right: 10,
              top: 5,
              child: ZoomTapAnimation(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressListScreen()));
                },
                child: Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(0.8)),
                  child: Icon(
                    Icons.list,
                    color: addressProvider.savedAddressCondition
                        ? Colors.blue
                        : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 3,
              top: 40,
              child: TypeOfMap(
                mapType: _selectedMapType,
                onChanged: (mapType) {
                  setState(() {
                    _selectedMapType = mapType;
                  });
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 90,
              child: ZoomTapAnimation(
                onTap: () {
                  setState(() {
                    context.read<AddressCallProvider>().getAddressByLatLong(
                          latLng: currentCameraPosition.target,
                        );
                    _selectedLocation = widget.latLong;
                    initialCameraPosition =
                        CameraPosition(target: _selectedLocation, zoom: 15);
                  });
                  _fetchAddress(widget.latLong);
                },
                child: Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(0.8)),
                  child: Icon(
                    Icons.man,
                    color: _selectedLocation == widget.latLong
                        ? Colors.amber
                        : Colors.white,
                  ),
                ),
              ),
            ),
            const Positioned(top: 125, right: 2, child: KindOfAddress()),
            const Positioned(top: 165, right: 2, child: LanguageOfAddress()),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const SaveAddressButton());
  }
}
