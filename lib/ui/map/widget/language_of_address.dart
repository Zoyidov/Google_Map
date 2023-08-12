import 'package:flutter/material.dart';
import 'package:login_screen_homework/utils/constants.dart';
import 'package:login_screen_homework/utils/icons.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/address_call_provider.dart';

class LanguageOfAddress extends StatefulWidget {
  const LanguageOfAddress({Key? key}) : super(key: key);

  @override
  State<LanguageOfAddress> createState() => _LanguageOfAddressState();
}

class _LanguageOfAddressState extends State<LanguageOfAddress> {
  String selectedLang = langList.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 33,
        width: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.8),
        ),
        child: ClipOval(
          child: Image.asset(
            selectedLang == langList[0]
                ? AppImages.uz
                : selectedLang == langList[1]
                    ? AppImages.rus
                    : selectedLang == langList[2]
                        ? AppImages.usa
                        : AppImages.turk,
            fit: BoxFit.cover,
          ),
        ),
      ),
      initialValue: selectedLang,
      onSelected: (String value) {
        setState(() {
          selectedLang = value;
        });

        context.read<AddressCallProvider>().updateLang(selectedLang);
      },
      itemBuilder: (BuildContext context) {
        return langList.asMap().entries.map<PopupMenuEntry<String>>(
          (MapEntry<int, String> entry) {
            int index = entry.key;
            String value = entry.value;
            String text;
            switch (index) {
              case 1:
                text = 'Русский';
                break;
              case 2:
                text = 'English';
                break;
              case 3:
                text = 'Turkish';
                break;
              default:
                text = 'Uzbek';
            }

            return PopupMenuItem<String>(
              value: value,
              child: Text(text,style: const TextStyle(color: Colors.white),),
            );
          },
        ).toList();
      },
    );
  }
}
