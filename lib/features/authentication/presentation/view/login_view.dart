import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/widgets/text_form_field.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:local_auth/local_auth.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(
          () {
            _supportState = isSupported;
          },
        ));
  }

  Future<void> _getAvailablebiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("List Of available biometrics + $availableBiometrics");
    if (!mounted) {
      return;
    }
  }

  Future<void> _authenticate() async {
    try {
      bool authenticate = await auth.authenticate(
          localizedReason: 'authenticate using your finger print',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      print("Authenticated :$authenticate");
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> authKey = GlobalKey();

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    'https://images.unsplash.com/photo-1560759226-14da22a643ef?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Center(
                    child: GlassContainer(
                      height: 400,
                      width: 300,
                      borderRadius: BorderRadius.circular(20),
                      blur: 20,
                      border: Border.all(color: Colors.white, width: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              hintText: "username",
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              hintText: "password",
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: double.infinity,
                              child: GlassContainer(
                                height: 50,
                                width: double.infinity,
                                borderRadius: BorderRadius.circular(20),
                                blur: 20,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                child: TextButton(
                                  onPressed: () async {
                                    await _getAvailablebiometrics();

                                    await _authenticate();
                                    // ignore: use_build_context_synchronously
                                    await ref
                                        .watch(authViewModelProvider.notifier)
                                        .signInUser(
                                            context,
                                            usernameController.text,
                                            passwordController.text);
                                  },
                                  child: const Text(
                                    "login",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Don't have an account ??",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.signUpRoute,
                                    );
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoute.forgotPassRoute);
                              },
                              child: const Text("Forgot Password"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// for testing 

// class LoginView extends ConsumerStatefulWidget {
//   const LoginView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
// }

// class _LoginViewState extends ConsumerState<LoginView> {
//   late final LocalAuthentication auth;
//   // bool _supportState = false;

//   // @override
//   // void initState() {
//     // super.initState();
//     // auth = LocalAuthentication();
//   //   auth.isDeviceSupported().then((bool isSupported) => setState(
//   //         () {
//   //           _supportState = isSupported;
//   //         },
//   //       ));
//   // }

//   // Future<void> _getAvailablebiometrics() async {
//   //   List<BiometricType> availableBiometrics =
//   //       await auth.getAvailableBiometrics();
//   //   print("List Of available biometrics + $availableBiometrics");
//   //   if (!mounted) {
//   //     return;
//   //   }
//   // }

//   // Future<void> _authenticate() async {
//   //   try {
//   //     bool authenticate = await auth.authenticate(
//   //         localizedReason: 'authenticate using your finger print',
//   //         options: const AuthenticationOptions(
//   //           stickyAuth: true,
//   //           biometricOnly: true,
//   //         ));
//   //     print("Authenticated :$authenticate");
//   //   } on PlatformException catch (e) {
//   //     print(e);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormState> authKey = GlobalKey();

//     TextEditingController usernameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Discussion Forum"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: <Widget>[
//             // const RiveAnimation.asset(
//             //   'assets/images/polar-bear.riv',
//             //   fit: BoxFit.cover, // Ensure the animation covers the entire space
//             // ),
//             Form(
//               key: authKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   CustomTextFormField(
//                     hintText: "username",
//                     controller: usernameController,
//                     color: Colors.black,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your email";
//                       }
//                       return null;
//                     },
//                   ), //custom text form field
//                   CustomTextFormField(
//                     hintText: "password",
//                     controller: passwordController,
//                     color: Colors.black,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your password";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),

//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     height: 100,
//                     width: double.infinity,
//                     child: TextButton(
//                       onPressed: () async {
//                         // await _getAvailablebiometrics();

//                         // await _authenticate();
//                         // ignore: use_build_context_synchronously
//                         await ref
//                             .watch(authViewModelProvider.notifier)
//                             .signInUser(context, usernameController.text,
//                                 passwordController.text);
//                       },
//                       child: const Text(
//                         "login",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account ??",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w500),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(
//                             context,
//                             AppRoute.signUpRoute,
//                           );
//                         },
//                         child: const Text(
//                           "SignUp",
//                           style: TextStyle(
//                               fontSize: 19, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
