import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo)
                .animate()
                .fade(
                  begin: 0,
                  end: 1,
                  duration: 3.seconds,
                )
                .shake(
                  hz: 4,
                  duration: 0.5.seconds,
                  delay: 3.seconds,
                )
                .flipH(
                  begin: 0,
                  end: 2,
                  curve: const FlippedCurve(Curves.easeInOutBack),
                  duration: 1.5.seconds,
                  delay: 1.5.seconds,
                )
                .animate(
                  onComplete: (controller) => controller.repeat(reverse: true),
                  delay: 3.seconds,
                )
                .shimmer(duration: 2.seconds),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: ElevatedButton(
                onPressed: () async {
                  if (await isLogged()) {
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (route) => false,
                      );
                    }
                  } else {
                    if (mounted) {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    }
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.white,
                      size: 34,
                    ),
                    SizedBox(width: 10),
                    Text('ENTRAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
