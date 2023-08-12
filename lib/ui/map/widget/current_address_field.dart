import 'package:flutter/material.dart';
import 'package:login_screen_homework/data/providers/address_call_provider.dart';
import 'package:provider/provider.dart';

class CurrentAddressField extends StatelessWidget {
  const CurrentAddressField({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: const EdgeInsets.only(top: 5,left: 5,right: 50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
      color: Colors.black.withOpacity(0.8)
      ),
      child: Text(
        context.read<AddressCallProvider>().scrolledAddressText,
        style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),
      ),
    );
  }
}