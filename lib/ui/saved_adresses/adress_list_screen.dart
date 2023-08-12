import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_screen_homework/utils/icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../data/providers/api_provider.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final addresses = addressProvider.addresses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.8),
        title: SvgPicture.asset(
          AppImages.profile,
          height: 120,
        ),
        actions: [
          TextButton(
              onPressed: () {
                addresses.isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.black.withOpacity(0.8),
                        content: const Text('List of Addresses is empty!'),
                      ))
                    : _showClearConfirmationDialog(context);
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: addresses.isEmpty
          ? Center(child: Lottie.asset(AppImages.location))
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Dismissible(
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      addressProvider.deleteAddress(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.black.withOpacity(0.8),
                        content: const Text('Location deleted'),
                      ));
                    }
                  },
                  confirmDismiss: (DismissDirection direction) async {
                    return direction == DismissDirection.endToStart;
                  },
                  background: Container(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Delete      ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  key: Key(index.toString()),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          address.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SvgPicture.asset(
                          AppImages.me,
                          height: 20,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '${address.address},',
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showClearConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear Address List'),
          content:
              const Text('Are you sure you want to clear the address list?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('Cancel',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                Provider.of<AddressProvider>(context, listen: false)
                    .deleteAllAddresses();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black.withOpacity(0.8),
                    content: const Text('All locations are deleted!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('Clear', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
