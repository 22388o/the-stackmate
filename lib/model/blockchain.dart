import 'package:hive/hive.dart';

part 'blockchain.g.dart';

@HiveType(typeId: 4, adapterName: 'BlockchainClassAdapter')
enum Blockchain {
  @HiveField(0)
  main,

  @HiveField(1)
  test,
}

extension Blo on Blockchain {
  String get name => const {
        Blockchain.main: 'main',
        Blockchain.test: 'test',
      }[this]!;

  String get displayName => const {
        Blockchain.main: 'mainnet',
        Blockchain.test: 'testnet',
      }[this]!;
}
