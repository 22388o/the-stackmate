// ignore_for_file: constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/fees.dart';
import 'package:sats/model/node.dart';
import 'package:sats/model/result.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/_locator.dart';
import 'package:sats/pkg/interface/storage.dart';

enum StoreKeys {
  Wallet,
  Blockchain,
  Node,
  Fees,
}

extension StoreKeysFunctions on StoreKeys {
  String get name => const {
        StoreKeys.Wallet: 'wallet',
        StoreKeys.Blockchain: 'blockchain',
        StoreKeys.Node: 'node',
        StoreKeys.Fees: 'fees',
      }[this]!;
}

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WalletClassAdapter());
  Hive.registerAdapter(BlockchainClassAdapter());
  Hive.registerAdapter(NodeClassAdapter());
  Hive.registerAdapter(FeesClassAdapter());

  await Hive.openBox<Wallet>(StoreKeys.Wallet.name);
  await Hive.openBox<Blockchain>(StoreKeys.Blockchain.name);
  await Hive.openBox<Node>(StoreKeys.Node.name);
  await Hive.openBox<Fees>(StoreKeys.Fees.name);

  await Hive.openBox<String>('storage');
}

class HiveStore implements IStorage {
  final _box = Hive.box<String>('storage');

  @override
  Future<R<int>> saveItem<T>(String cls, T obj) async {
    try {
      final id = await Hive.box<T>(cls).add(obj);
      return R(result: id);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<bool>> saveItemAt<T>(String cls, int idx, T obj) async {
    try {
      await Hive.box<T>(cls).put(idx, obj);
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<bool> deleteItem<T>(String cls, String key) {
    try {
      Hive.box<T>(cls).delete(key);
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<bool>> clearAll<T>(String cls) async {
    try {
      await Hive.box<T>(cls).clear();
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<T> getItem<T>(String cls, String key) {
    try {
      return R(result: Hive.box<T>(cls).get(key));
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<List<T>> getAll<T>(String cls) {
    try {
      return R(result: Hive.box<T>(cls).values.toList());
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<bool>> saveOrUpdateOne(String key, String value) async {
    try {
      _box.put(key, value);
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<String>> getOne(String key) async {
    try {
      final str = _box.get(key);
      if (str == null) {
        return R(error: 'empty');
      }
      return R(result: str);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<bool>> deleteOne(String key) async {
    try {
      _box.delete(key);

      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<T> getFirstItem<T>(String cls) {
    try {
      final bx = Hive.box<T>(cls);
      final len = bx.length;
      if (len == 0) throw 'empty';
      final obj = bx.getAt(0);
      if (obj == null) throw 'empty';
      return R(result: obj);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<T?> getFirstItemOrNull<T>(String cls) {
    try {
      final bx = Hive.box<T>(cls);
      final len = bx.length;
      if (len == 0) return throw '';
      final obj = bx.getAt(0);
      return R(result: obj);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  R<bool> deleteItemAt<T>(String cls, int idx) {
    try {
      Hive.box<T>(cls).delete(idx);
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }
}
