import 'dart:ffi';
import 'package:bitcoin/types.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sats/api/stackmate-core.dart';
import 'package:sats/api/interface/stackmate-core.dart';
import 'package:sats/cubit/node.dart';
import 'package:sats/cubit/chain-select.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sats/model/fees.dart';
import 'package:sats/pkg/interface/storage.dart';
import 'package:sats/pkg/storage.dart';

part 'fees.freezed.dart';

@freezed
class FeesState with _$FeesState {
  const factory FeesState(
      {@Default(Fees(timestamp: 0, slow: 0.0, medium: 0.0, fast: 0.0))
          Fees fees,
      @Default(false)
          bool updating,
      @Default('')
          String errUpdating}) = _FeesState;
}

class FeesCubit extends Cubit<FeesState> {
  FeesCubit(
    this._storage,
    this._blockchain,
    this._nodeAddressCubit,
  ) : super(const FeesState()) {
    init();
  }

  final IStorage _storage;
  final ChainSelectCubit _blockchain;
  final NodeAddressCubit _nodeAddressCubit;

  Future init() async {
    try {
      emit(state.copyWith(updating: true, errUpdating: ''));
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final fees = _storage.getFirstItem<Fees>(StoreKeys.Fees.name);
      if (fees.hasError) {
        if (fees.error! == 'empty') {
          final defaultFees = Fees(
              timestamp: timestamp, slow: 0.000, medium: 0.000, fast: 0.000);
          emit(
            state.copyWith(fees: defaultFees),
          );
        } else
          emit(state.copyWith(errUpdating: fees.error.toString()));
      } else {
        emit(
          state.copyWith(
            // ignore: unnecessary_null_checks
            fees: fees.result!,
          ),
        );
      }

      final nodeAddress = _nodeAddressCubit.state.getAddress();

      final fastRate = BitcoinFFI().estimateNetworkFee(
        network: _blockchain.state.blockchain.name,
        nodeAddress: nodeAddress,
        targetSize: '1',
      );

      if (fastRate.hasError) {
        throw SMError.fromJson(fastRate.error!);
      }

      final slowRate = BitcoinFFI().estimateNetworkFee(
        network: _blockchain.state.blockchain.name,
        nodeAddress: nodeAddress,
        targetSize: '21',
      );

      if (slowRate.hasError) {
        throw SMError.fromJson(slowRate.error!);
      }

      final mediumRate = (fastRate.result! + slowRate.result!) / 2;

      final feesUpdated = Fees(
        timestamp: timestamp,
        slow: slowRate.result!,
        medium: mediumRate,
        fast: fastRate.result!,
      );

      emit(
        state.copyWith(
          fees: feesUpdated,
        ),
      );

      final cleared = await _storage.clearAll<Fees>(StoreKeys.Fees.name);
      if (cleared.hasError) {
        emit(state.copyWith(errUpdating: cleared.error.toString()));
        return;
      }

      final saved =
          await _storage.saveItem<Fees>(StoreKeys.Fees.name, feesUpdated);
      if (saved.hasError) {
        emit(state.copyWith(errUpdating: saved.error.toString()));
        return;
      }
      emit(
        state.copyWith(updating: false, errUpdating: ''),
      );
      return;
    } catch (e) {
      print(e.toString());
    }
  }

  Fees getFees() {
    return state.fees;
  }

  Future update() async {
    try {
      emit(state.copyWith(updating: true, errUpdating: ''));
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final nodeAddress = _nodeAddressCubit.state.getAddress();
      final fastRate = BitcoinFFI().estimateNetworkFee(
        network: _blockchain.state.blockchain.name,
        nodeAddress: nodeAddress,
        targetSize: '1',
      );

      final slowRate = BitcoinFFI().estimateNetworkFee(
        network: _blockchain.state.blockchain.name,
        nodeAddress: nodeAddress,
        targetSize: '21',
      );

      final mediumRate = (fastRate.result! + slowRate.result!) / 2;

      final feesUpdated = Fees(
        timestamp: timestamp,
        slow: slowRate.result!,
        medium: mediumRate,
        fast: fastRate.result!,
      );

      emit(
        state.copyWith(
          fees: feesUpdated,
        ),
      );

      final cleared = await _storage.clearAll<Fees>(StoreKeys.Fees.name);
      if (cleared.hasError) {
        emit(state.copyWith(errUpdating: cleared.error.toString()));
        return;
      }

      final saved =
          await _storage.saveItem<Fees>(StoreKeys.Fees.name, feesUpdated);
      if (saved.hasError) {
        emit(state.copyWith(errUpdating: saved.error.toString()));
        return;
      }
      emit(
        state.copyWith(updating: false, errUpdating: ''),
      );
      return;
    } catch (e) {
      print(e.toString());
    }
  }
}
