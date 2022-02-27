import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/routes.dart';

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
    return GestureDetector(
      onTap: () {
        context.read<WalletsCubit>().walletSelected(wallet);
        if (!isSelection) {
          Navigator.pushNamed(
            context,
            Routes.wallet,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              height: 180,
              width: 150,
              padding: const EdgeInsets.all(16),
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
                  const SizedBox(height: 16),
                  Text(
                    wallet.label,
                    style: context.fonts.subtitle1!.copyWith(
                      color: context.colours.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (wallet.balance != null) ...[
                    const Spacer(),

                    // const SizedBox(height: 8),
                    Text(
                      'BALANCE',
                      style: context.fonts.overline!.copyWith(
                        color: context.colours.onBackground,
                        fontSize: 8,
                      ),
                    ),
                    Text(
                      wallet.balance.toString() + ' sats',
                      // overflow: TextOverflow.ellipsis,
                      maxLines: 10,

                      style: context.fonts.caption!.copyWith(
                        color: context.colours.onBackground.withOpacity(0.8),
                        // fontSize: 8,
                      ),
                    ),
                  ],
                  const Spacer(flex: 4),
                  Text(
                    wallet.walletType,
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.end,
                    maxLines: 10,
                    style: context.fonts.caption!.copyWith(
                      color: context.colours.onBackground,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
