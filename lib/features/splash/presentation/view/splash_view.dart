import 'package:discussion_forum/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 4), () {
      ref.read(splashViewModelProvider.notifier).init(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: RiveAnimation.asset(
                    'assets/images/loading_book.riv',
                    fit: BoxFit
                        .cover, // Ensure the animation covers the entire space
                  ),
                ),
                Text(
                  'Discussion Forum',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Duktar Tamang')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
