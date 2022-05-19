import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sats/pkg/_locator.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/ui/cubits.dart';
import 'package:sats/ui/screen/AddWallet.dart';
import 'package:sats/ui/screen/Calculator.dart';
import 'package:sats/ui/screen/Home.dart';
import 'package:sats/ui/screen/Logs.dart';
import 'package:sats/ui/screen/NewWallet/SeedGenerate.dart';
import 'package:sats/ui/screen/NewWallet/SeedImport.dart';
import 'package:sats/ui/screen/NewWallet/XpubImport.dart';
import 'package:sats/ui/screen/PSBT.dart';
import 'package:sats/ui/screen/Receive.dart';
import 'package:sats/ui/screen/Send.dart';
import 'package:sats/ui/screen/Settings.dart';
import 'package:sats/ui/screen/Wallet.dart';
import 'package:sats/ui/style.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

void main() async {
  await initializeHive();
  setupDependencies(useDummies: false);

  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runZonedGuarded(
    () => runApp(Stackmate()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class Stackmate extends StatefulWidget {
  const Stackmate({Key? key}) : super(key: key);

  @override
  State<Stackmate> createState() => _StackmateState();
}

class _StackmateState extends State<Stackmate> {
  bool isAuth = false;

  void _checkBiometric() async {
    // check for biometric availability
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print("error biometrics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    // enumerate biometric technologies
    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");

    // authenticate with biometrics
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Touch your finger on the sensor to login',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print("error using biometric auth: $e");
    }
    setState(() {
      isAuth = authenticated ? true : false;
    });

    print("authenticated: $authenticated");
  }

  @override
  Widget build(BuildContext c) {
    return isAuth
        ? Cubits(
            child: OKToast(
              duration: const Duration(milliseconds: 2000),
              position: ToastPosition.bottom,
              textStyle:
                  c.fonts.caption!.copyWith(color: c.colours.onBackground),
              child: MaterialApp.router(
                routeInformationParser: _router.routeInformationParser,
                routerDelegate: _router.routerDelegate,
                // localizationsDelegates: const [
                //   AppLocalizations.delegate,
                //   GlobalMaterialLocalizations.delegate,
                // ],
                // supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) {
                  final mediaQueryData = MediaQuery.of(context);
                  return MediaQuery(
                    data: mediaQueryData.copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                theme: derivedTheme(mainTheme()),
              ),
            ),
          )
        : MaterialApp(
            home: Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: InkWell(
                    onTap: () {
                      _checkBiometric();
                    },
                    child: SimpleDialog(
                      elevation: 1,
                      backgroundColor:Colors.white70,
                      title: const Text('       Unlock Stackmate'),
                      children: <Widget>[
                        Icon(
                          Icons.fingerprint,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }

  late final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/calc',
        builder: (_, __) => const CalculatorScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/network',
        builder: (_, __) => Container(),
      ),
      GoRoute(
        path: '/add-wallet',
        builder: (_, __) => const AddWalletScreen(),
      ),
      GoRoute(
        path: '/psbt-tools',
        builder: (_, __) => const PSBTScreen(),
      ),
      GoRoute(
        path: '/generate-seed',
        builder: (_, __) => const SeedGenerateScreen(),
      ),
      GoRoute(
        path: '/import-seed',
        builder: (_, __) => const SeedImportScreen(),
      ),
      GoRoute(
        path: '/watch-only',
        builder: (_, __) => const XPubImportScreen(),
      ),
      GoRoute(
        path: '/wallet',
        builder: (_, __) => const WalletScreen(),
      ),
      GoRoute(
        path: '/receive',
        builder: (_, __) => const ReceiveScreen(),
      ),
      GoRoute(
        path: '/send',
        builder: (_, __) => const WalletSendScreen(
          fromQr: false,
        ),
      ),
      GoRoute(
        path: '/send-from-qr',
        builder: (_, __) => const WalletSendScreen(
          fromQr: true,
        ),
      ),
      GoRoute(
        path: '/logs',
        builder: (_, __) => const LogsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Container(color: Colors.red),
  );
}
