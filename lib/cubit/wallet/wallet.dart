import 'package:bitcoin/types.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/api/stackmate-core.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/node.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/interface/launcher.dart';
import 'package:sats/pkg/interface/share.dart';
import 'package:sats/pkg/interface/storage.dart';
import 'package:sats/pkg/interface/vibrate.dart';
import 'package:sats/pkg/storage.dart';

part 'wallet.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(false) bool loadingTransactions,
    @Default('') String errLoadingTransactions,
    @Default(true) bool loadingBalance,
    @Default('') String errLoadingBalance,
    int? balance,
    List<Transaction>? transactions,
    @Default('') String errDeleting,
    @Default(false) bool deleted,
    @Default(false) bool showInfo,
  }) = _WalletState;
  const WalletState._();

  bool zeroBalance() => balance == null || balance == 0;
  bool zeroBalanceAmt() => balance != null && balance == 0;
}

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(
    this._walletsCubit,
    // this._bitcoin,
    this._storage,
    this._logger,
    // this._blockchain,
    this._launcher,
    this._share,
    this._vibrate,
    this._nodeAddressCubit,
    this._blockchainCubit,
  ) : super(const WalletState()) {
    // scheduleMicrotask(() async {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   getHistory();
    // });
    // getHistory();

    // getHistory();
    _init();
  }

  final WalletsCubit _walletsCubit;
  // final IBitcoin _bitcoin;
  final IStorage _storage;
  final Logger _logger;
  // final BlockchainCubit _blockchain;
  final IShare _share;
  final ILauncher _launcher;
  final IVibrate _vibrate;
  final ChainSelectCubit _blockchainCubit;
  final NodeAddressCubit _nodeAddressCubit;

  static const blockstreamTestnetURL = 'https://blockstream.info/testnet/tx/';
  static const blockstreamMainnetURL = 'https://blockstream.info/tx/';
  static const emailShareSubject = 'Transaction Details';
  static const walletHasFunds = 'Wallet has funds';

  void _init() async {
    // await Future.delayed(const Duration(millis .econds: 1000));

    getHistory();
  }

  void getHistory() async {
    try {
      emit(
        state.copyWith(
          loadingBalance: true,
          errLoadingTransactions: '',
        ),
      );

      final node = _nodeAddressCubit.state.getAddress();
      final wallet = _walletsCubit.state.selectedWallet!;

      emit(
        state.copyWith(
          loadingBalance: true,
          loadingTransactions: true,
          balance: wallet.balance,
          transactions: wallet.transactions,
        ),
      );

      final bal = await compute(computeBalance, {
        'descriptor': wallet.descriptor,
        'nodeAddress': node,
      });

      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingBalance: false,
          loadingTransactions: true,
          balance: bal,
        ),
      );

      final transactions = await compute(computeHistory, {
        'descriptor': _walletsCubit.state.selectedWallet!.descriptor,
        'nodeAddress': node,
        // 'network': _blockchain.state.blockchain.name,
      });

      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingTransactions: false,
          transactions: transactions,
          errLoadingTransactions: '',
        ),
      );

      _walletsCubit.addBalanceToSelectedWallet(bal);
      _walletsCubit.addTransactionsToSelectedWallet(transactions);
      return;
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingBalance: false,
          loadingTransactions: false,
          errLoadingTransactions: e.toString(),
        ),
      );
      _logger.logException(e, 'HistoryCubit.getHistory', s);
    }
  }

  void openLink(Transaction transaction) {
    try {
      String url = '';
      if (_blockchainCubit.state.blockchain == Blockchain.testNet)
        url = blockstreamTestnetURL;
      else
        url = blockstreamMainnetURL;

      url += transaction.txid;

      _launcher.launchApp(url);
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.openLink', s);
    }
  }

  void shareTransaction(Transaction transaction) {
    try {
      String text = '';

      text += 'Amount: ' + transaction.amountToBtc() + ' BTC';
      text += '\nTxId: ' + transaction.txid;
      // text += '\nAddress: ' + transaction.address;
      text += '\nFee: ' + transaction.feesToBtc() + ' BTC';

      _share.share(text: text, subjectForEmail: emailShareSubject);
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.shareTransaction', s);
    }
  }

  void deleteClicked() {
    emit(state.copyWith(errDeleting: ''));

    if (state.balance == null || state.balance! > 0) {
      emit(state.copyWith(errDeleting: walletHasFunds));
      return;
    }

    _storage.deleteItemAt<Wallet>(
      StoreKeys.Wallet.name,
      _walletsCubit.state.selectedWallet!.id!,
    );

    _walletsCubit.refresh();

    emit(state.copyWith(deleted: true));
  }

  void toggleShowInfo() {
    emit(state.copyWith(showInfo: !state.showInfo));
  }
}

List<Transaction> computeHistory(dynamic obj) {
  final data = obj as Map<String, String?>;
  final resp = BitcoinFFI().getHistory(
    descriptor: data['descriptor']!,
    nodeAddress: data['nodeAddress']!,
  );

  if (resp.hasError) {
    throw SMError.fromJson(resp.error!);
  }
  return resp.result!;
}

int computeBalance(dynamic obj) {
  final data = obj as Map<String, String?>;
  final resp = BitcoinFFI().syncBalance(
    descriptor: data['descriptor']!,
    nodeAddress: data['nodeAddress']!,
  );
  if (resp.hasError) {
    throw SMError.fromJson(resp.error!);
  }
  return resp.result!;
}
