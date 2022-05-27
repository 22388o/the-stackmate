import 'package:flutter/material.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/pkg/extensions.dart';

class TransactionComplete extends StatelessWidget {
  const TransactionComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletsCubit w) => w.state.selectedWallet!);
    if (wallet.isNotWatchOnly())
      return Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Transaction\nBroadcasted.',
              style: context.fonts.headline5!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Check your wallet history for details.',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'PSBT\nCopied to Clipboard.',
              style: context.fonts.headline5!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Pass it to a signer.',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
  }
}
