import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/from-old-seed.dart';
import 'package:sats/pkg/extensions.dart';

class SeedImportLabel extends StatefulWidget {
  const SeedImportLabel({Key? key}) : super(key: key);

  @override
  State<SeedImportLabel> createState() => _SeedImportLabelState();
}

class _SeedImportLabelState extends State<SeedImportLabel> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportWalletCubit, SeedImportWalletState>(
      buildWhen: (previous, current) =>
          previous.walletLabelError != current.walletLabelError,
      builder: (context, state) {
        if (state.walletLabel != _controller!.text)
          _controller!.text = state.walletLabel;

        final isFixed = state.labelFixed;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              isFixed ? 'Label' : 'Label your wallet',
              style: c.fonts.headline4!.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.zero,
              child: IgnorePointer(
                ignoring: isFixed,
                child: TextField(
                  controller: _controller,
                  onChanged: (text) {
                    if (!isFixed)
                      c.read<SeedImportWalletCubit>().labelChanged(text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Wallet Name',
                    labelStyle: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (state.walletLabelError != '')
              Text(
                state.walletLabelError,
                style: c.fonts.caption!.copyWith(color: c.colours.error),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  c.read<SeedImportWalletCubit>().nextClicked();
                },
                child: const Text('Confirm'),
              ),
            )
          ],
        );
      },
    );
  }
}
