import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/pkg/_locator.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/ui/cubits.dart';
import 'package:sats/ui/screen/AddWallet.dart';
import 'package:sats/ui/screen/CypherPost.dart';
import 'package:sats/ui/screen/Home.dart';
import 'package:sats/ui/screen/Landing.dart';
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
// ignore: import_of_legacy_library_into_null_safe

void main() async {
  await initializeHive();
  setupDependencies(useDummies: false);

  WidgetsFlutterBinding.ensureInitialized();
  // final p = ReceivePort();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runZonedGuarded(
    () => runApp(Stackmate()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class Stackmate extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    compute(
      daemonStart,
      {
        'path': Directory.systemTemp.toString(),
        'socks5Port': '39050',
        'httpProxy': '',
      },
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Cubits(
      child: OKToast(
        duration: const Duration(milliseconds: 2000),
        position: ToastPosition.bottom,
        textStyle: c.fonts.caption!.copyWith(color: c.colours.onBackground),
        child: MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
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
    );
  }

  late final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const LandingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/network',
        builder: (_, __) => const CypherPostHomeScreen(),
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
