import 'package:discussion_forum/core/common/provider/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InternetCheck extends StatelessWidget {
  const InternetCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final connectivityStatus = ref.watch(connectivityStatusProvider);
            if (connectivityStatus == ConnectivityStatus.isConnected) {
              return const Text(
                'Connected',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return const Text(
                'Disconnected',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
