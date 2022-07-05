import 'package:flutter/material.dart';

class ConformDialog extends StatelessWidget {
  const ConformDialog({
    Key? key,
    required this.title,
    required this.onConform,
    this.onCancel,
  }) : super(key: key);
  final String title;
  final Function onConform;
  final Function? onCancel;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: AlertDialog(
        content: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(onPressed: () => onConform(), child: const Text('Yes'))
        ],
      ),
    );
  }
}
