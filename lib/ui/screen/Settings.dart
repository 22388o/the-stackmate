import 'package:flutter/material.dart';
import 'package:sats/ui/component/Home/Actions.dart';
import 'package:sats/ui/component/Settings/Incognito.dart';
import 'package:sats/ui/component/Settings/Save.dart';
import 'package:sats/ui/component/Settings/SelectNetwork.dart';
import 'package:sats/ui/component/Settings/SelectNode.dart';
import 'package:sats/ui/component/common/header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(
                height: 12,
              ),
              Header(
                cornerTitle: 'SETTINGS',
                children: [
                  SizedBox(height: 21),
                ],
              ),
              SizedBox(
                height: 28,
              ),
              SelectNode(),
              SizedBox(height: 16),
              SelectNetwork(),
              SizedBox(height: 16),
              SetIncognito(),
              SizedBox(height: 16),
              SavePreferences(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeActions(),
    );
  }
}
