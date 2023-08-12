import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_screen_homework/utils/icons.dart';

class TypeOfMap extends StatefulWidget {
  const TypeOfMap({Key? key, required this.mapType, required this.onChanged})
      : super(key: key);

  final MapType mapType;
  final ValueChanged<MapType> onChanged;

  @override
  State<TypeOfMap> createState() => _TypeOfMapState();
}

class _TypeOfMapState extends State<TypeOfMap> {
  late MapType _selectedMapType;

  @override
  void initState() {
    super.initState();
    _selectedMapType = widget.mapType;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MapType>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black.withOpacity(0.8)),
        child: Icon(
          Icons.map_rounded,
          color: _selectedMapType == MapType.satellite
              ? const Color(0xFF00ACC1)
              : _selectedMapType == MapType.hybrid
              ? const Color(0xFF00ACC1)
              : Colors.white,
        ),
      ),
      onSelected: (MapType result) {
        setState(() {
          _selectedMapType = result;
        });
        widget.onChanged(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
        _buildMapTypeMenuItem(
          text: 'Normal',
          mapType: MapType.normal,
          iconPath: AppImages.normal,
        ),
        _buildMapTypeMenuItem(
          text: 'Satellite',
          mapType: MapType.satellite,
          iconPath: AppImages.satellite,
        ),
        _buildMapTypeMenuItem(
          text: 'Hybrid',
          mapType: MapType.hybrid,
          iconPath: AppImages.hybrid,
        ),
        _buildMapTypeMenuItem(
          text: 'Terrain',
          mapType: MapType.terrain,
          iconPath: AppImages.terrain,
        ),
      ],
    );
  }

  PopupMenuItem<MapType> _buildMapTypeMenuItem({
    required String text,
    required MapType mapType,
    required String iconPath,
  }) {
    return PopupMenuItem<MapType>(
      onTap: () {
        setState(() {
          _selectedMapType = mapType;
        });
        widget.onChanged(mapType);
      },
      value: mapType,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          Image.asset(iconPath, height: 30, width: 30),
        ],
      ),
    );
  }
}