//
// import 'package:flutter/material.dart';
//
// import '../util/constant.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animation controller for 5 seconds
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     );
//
//     // Create a tween from 0.0 to 1.0 (0% to 100%)
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {}); // Rebuild on each animation tick
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _navigateToHome();
//         }
//       });
//
//     // Start the animation
//     _controller.forward();
//   }
//
//   Future<void> _navigateToHome() async {
//     if (!mounted) return;
//
//     // TODO: Check if user is logged in
//     // bool isLoggedIn = await checkLoginStatus();
//     // Navigator.pushReplacementNamed(
//     //   context,
//     //   isLoggedIn ? '/' : '/signin',
//     // );
//
//     Navigator.pushReplacementNamed(context, RouteHome);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/eplzonelogo3.jpeg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.black.withOpacity(0.6),
//                 Colors.black.withOpacity(0.4),
//                 Colors.black.withOpacity(0.6),
//               ],
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // App Icon/Logo
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 15,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.sports_soccer,
//                     size: 60,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//
//                 // App Name
//                 const Text(
//                   'EPL Zone',
//                   style: TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 2,
//                     shadows: [
//                       Shadow(
//                         color: Colors.black,
//                         blurRadius: 10,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//
//                 // Tagline
//                 const Text(
//                   'Premier League Hub',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white70,
//                     letterSpacing: 1,
//                     shadows: [
//                       Shadow(
//                         color: Colors.black,
//                         blurRadius: 5,
//                         offset: Offset(1, 1),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 48),
//
//                 // Linear Progress Bar Container
//                 Container(
//                   width: 250,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.white30),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Background
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//
//                       // Progress Bar
//                       AnimatedBuilder(
//                         animation: _animation,
//                         builder: (context, child) {
//                           return Container(
//                             width: 250 * _animation.value,
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color(0xFF0055A4),
//                                   Color(0xFF00C2FF),
//                                 ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           );
//                         },
//                       ),
//
//                       // Progress Text
//                       Center(
//                         child: AnimatedBuilder(
//                           animation: _animation,
//                           builder: (context, child) {
//                             return Text(
//                               '${(_animation.value * 100).round()}%',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.black,
//                                     blurRadius: 3,
//                                     offset: Offset(1, 1),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Loading Text
//                 const Text(
//                   'Loading...',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                     shadows: [
//                       Shadow(
//                         color: Colors.black,
//                         blurRadius: 3,
//                         offset: Offset(1, 1),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // // Splash screen to check authentication status
// // class SplashScreen extends ConsumerStatefulWidget {
// //   const SplashScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// // }
// //
// // class _SplashScreenState extends ConsumerState<SplashScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkAuthStatus();
// //   }
// //
// //   Future<void> _checkAuthStatus() async {
// //     // Wait a bit for splash effect
// //     await Future.delayed(const Duration(seconds: 2));
// //
// //     if (!mounted) return;
// //
// //     final authService = ref.read(authServiceProvider);
// //     final isLoggedIn = await authService.isLoggedIn();
// //
// //     if (!mounted) return;
// //
// //     if (isLoggedIn) {
// //       Navigator.pushReplacementNamed(context, RouteHome);
// //     } else {
// //       Navigator.pushReplacementNamed(context, RouteSignIn);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.sports_soccer,
// //               size: 100,
// //               color: Theme.of(context).colorScheme.primary,
// //             ),
// //             const SizedBox(height: 24),
// //             Text(
// //               'PremierZone',
// //               style: Theme.of(context).textTheme.displayLarge?.copyWith(
// //                 fontWeight: FontWeight.bold,
// //                 color: Theme.of(context).colorScheme.primary,
// //               ),
// //             ),
// //             const SizedBox(height: 48),
// //             const CircularProgressIndicator(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }




// lib/features/splash/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider/auth_provider.dart';
import '../provider/player_provider/player_provider.dart';
import '../util/constant.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _loadingMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for 5 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Create a tween from 0.0 to 1.0 (0% to 100%)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // Update loading message based on progress
          if (_animation.value < 0.3) {
            _loadingMessage = 'Checking authentication...';
          } else if (_animation.value < 0.7) {
            _loadingMessage = 'Loading player data...';
          } else {
            _loadingMessage = 'Almost ready...';
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _initialize();
        }
      });

    // Start the animation
    _controller.forward();
  }

  Future<void> _initialize() async {
    if (!mounted) return;

    try {
      // Check authentication status
      final authService = ref.read(authServiceProvider);
      final isLoggedIn = await authService.isLoggedIn();

      // Preload player data (don't wait for it to complete)
      ref.read(allPlayersProvider);

      if (!mounted) return;

      // Navigate based on login status
      // Always go to home since login is not compulsory
      Navigator.pushReplacementNamed(context, RouteHome);
    } catch (e) {
      // Even if there's an error, navigate to home
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteHome);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/eplzonelogo3.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon/Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 32),

                // App Name
                const Text(
                  'EPL Zone',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline
                const Text(
                  'Premier League Hub',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Linear Progress Bar Container
                Container(
                  width: 250,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Stack(
                    children: [
                      // Progress Bar
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Container(
                            width: 250 * _animation.value,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF0055A4),
                                  Color(0xFF00C2FF),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),

                      // Progress Text
                      Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Text(
                              '${(_animation.value * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Loading Text
                Text(
                  _loadingMessage,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}