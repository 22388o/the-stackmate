import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/send.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/validation.dart';
import 'package:intl/intl.dart';

class ConfirmTransaction extends StatelessWidget {
  const ConfirmTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((SendCubit sc) => sc.state);
    final wallet = context.select((WalletsCubit w) => w.state.selectedWallet!);

    if (state.finalAmount == null) return Container();
    if (wallet.isNotWatchOnly())
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Transaction\nDetails',
              style: context.fonts.headline5!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Address'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '' + state.address,
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Amount'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.finalAmount.toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '' + state.finalAmount.toBtc() + ' BTC',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Network Fee'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.finalFee.toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Total'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.total().toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '' + state.total().toBtc() + ' BTC',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            TextButton(
              onPressed: () {
                context.read<SendCubit>().sendClicked();
              },
              child: const Text('SEND'),
            )
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Transaction\nDetails',
              style: context.fonts.headline5!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Address'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '' + state.address,
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Amount'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.finalAmount.toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '' + state.finalAmount.toBtc() + ' BTC',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Network Fee'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.finalFee.toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Total'.toUpperCase(),
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat('###,000')
                      .format(double.parse(state.total().toString())) +
                  ' sats',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '' + state.total().toBtc() + ' BTC',
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            TextButton(
              onPressed: () {
                context.read<SendCubit>().copyPSBT();
                // Future.delayed(Duration(seconds: 2));
              },
              child: const Text('COPY PSBT'),
            )
          ],
        ),
      );
  }
}
