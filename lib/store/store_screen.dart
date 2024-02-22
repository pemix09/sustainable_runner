import 'package:endless_runner/style/wobbly_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Store '),
          WobblyButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
