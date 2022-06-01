import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sats/pkg/extensions.dart';

class HomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              context.push('/home');
            },
            icon: Icon(
              Icons.account_balance_wallet_outlined,
              size: 32,
              color: context.colours.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.schema_outlined,
              size: 32,
              color: context.colours.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(
              Icons.settings,
              size: 32,
              color: context.colours.primary,
            ),
          ),
        ],
      ),
    );
  }
}
