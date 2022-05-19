import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sats/cubit/preferences.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/validation.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.wallet,
    this.isSelection = false,
  }) : super(key: key);

  final Wallet wallet;
  final bool isSelection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, prefState) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<WalletsCubit>().walletSelected(wallet);
                if (!isSelection) {
                  context.push('/wallet');
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 12),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: context.colours.background,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      // sigmaX: 0,
                      // sigmaY: 0,
                      tileMode: TileMode.mirror,
                    ),
                    child: Container(
                      height: 92,
                      width: context.width / 1.8,
                      padding: const EdgeInsets.only(
                        top: 21,
                        left: 12,
                        right: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          // end: Alignment.centerRight,
                          stops: const [0.3, 0.99],
                          colors: [
                            context.colours.surface,
                            context.colours.surface,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            wallet.label,
                            style: context.fonts.subtitle1!.copyWith(
                              color: context.colours.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            wallet.walletType,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: context.fonts.caption!.copyWith(
                              color: wallet.walletType == 'WATCHER'
                                  ? context.colours.secondary
                                  : context.colours.tertiary,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (!prefState.incognito)
                            Text(
                              Validation.formatSatsString(
                                    wallet.balance.toString(),
                                  ) +
                                  ' sats',
                              maxLines: 10,
                              style: context.fonts.caption!.copyWith(
                                color: context.colours.onBackground
                                    .withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<WalletsCubit>().walletSelected(wallet);
                if (!isSelection) {
                  context.push('/receive');
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 12),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: context.colours.background,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      tileMode: TileMode.mirror,
                    ),
                    child: Container(
                      height: 90,
                      width: 76,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          stops: const [0.3, 0.99],
                          colors: [
                            context.colours.surface,
                            context.colours.surface,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<WalletsCubit>()
                                  .walletSelected(wallet);
                              if (!isSelection) {
                                context.push('/receive');
                              }
                            },
                            icon: Icon(
                              Icons.call_received,
                              size: 24,
                              color: context.colours.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<WalletsCubit>().walletSelected(wallet);
                if (!isSelection) {
                  context.push('/send');
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 12),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: context.colours.background,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      tileMode: TileMode.mirror,
                    ),
                    child: Container(
                      height: 90,
                      width: 76,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          stops: const [0.3, 0.99],
                          colors: [
                            context.colours.surface,
                            context.colours.surface,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<WalletsCubit>()
                                  .walletSelected(wallet);
                              if (!isSelection) {
                                context.push('/send');
                              }
                            },
                            icon: Icon(
                              wallet.walletType == 'WATCHER'
                                  ? Icons.build
                                  : Icons.send,
                              size: 21,
                              color: context.colours.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
