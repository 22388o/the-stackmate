import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/from-old-seed.dart';
import 'package:sats/pkg/extensions.dart';

class SeedImportLabel extends StatelessWidget {
  const SeedImportLabel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportWalletCubit, SeedImportWalletState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.savingWallet,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: state.savingWallet ? 0.5 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Label your wallet',
                  style: c.fonts.headline4!.copyWith(
                    color: c.colours.onPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextField(
                    style:
                        c.fonts.headline6!.copyWith(color: c.colours.onPrimary),
                    onChanged: (text) {
                      c.read<SeedImportWalletCubit>().labelChanged(text);
                    },
                    decoration: InputDecoration(
                      labelText: 'Wallet Name',
                      labelStyle: TextStyle(color: c.colours.onPrimary),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (state.savingWalletError != '')
                  Text(
                    state.savingWalletError,
                    style: c.fonts.caption!.copyWith(color: c.colours.error),
                    textAlign: TextAlign.center,
                  ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: c.colours.primary,
                      onPrimary: c.colours.background,
                    ),
                    onPressed: () async {
                      context.read<SeedImportWalletCubit>().nextClicked();
                    },
                    child: const Text('Confirm'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
