// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get label => throw _privateConstructorUsedError;
  @HiveField(2)
  String get descriptor => throw _privateConstructorUsedError;
  @HiveField(3)
  String get policy => throw _privateConstructorUsedError;
  @HiveField(4)
  int get requiredPolicyElements => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get policyElements => throw _privateConstructorUsedError;
  @HiveField(6)
  String get blockchain => throw _privateConstructorUsedError;
  @HiveField(7)
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  @HiveField(8)
  int get balance => throw _privateConstructorUsedError;
  @HiveField(9)
  int get lastAddressIndex => throw _privateConstructorUsedError;
  @HiveField(10)
  String get walletType => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isNewWallet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String label,
      @HiveField(2) String descriptor,
      @HiveField(3) String policy,
      @HiveField(4) int requiredPolicyElements,
      @HiveField(5) List<String> policyElements,
      @HiveField(6) String blockchain,
      @HiveField(7) List<Transaction> transactions,
      @HiveField(8) int balance,
      @HiveField(9) int lastAddressIndex,
      @HiveField(10) String walletType,
      @HiveField(11) bool isNewWallet});
}

/// @nodoc
class _$WalletCopyWithImpl<$Res> implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  final Wallet _value;
  // ignore: unused_field
  final $Res Function(Wallet) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? descriptor = freezed,
    Object? policy = freezed,
    Object? requiredPolicyElements = freezed,
    Object? policyElements = freezed,
    Object? blockchain = freezed,
    Object? transactions = freezed,
    Object? balance = freezed,
    Object? lastAddressIndex = freezed,
    Object? walletType = freezed,
    Object? isNewWallet = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      descriptor: descriptor == freezed
          ? _value.descriptor
          : descriptor // ignore: cast_nullable_to_non_nullable
              as String,
      policy: policy == freezed
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      requiredPolicyElements: requiredPolicyElements == freezed
          ? _value.requiredPolicyElements
          : requiredPolicyElements // ignore: cast_nullable_to_non_nullable
              as int,
      policyElements: policyElements == freezed
          ? _value.policyElements
          : policyElements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockchain: blockchain == freezed
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lastAddressIndex: lastAddressIndex == freezed
          ? _value.lastAddressIndex
          : lastAddressIndex // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: walletType == freezed
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      isNewWallet: isNewWallet == freezed
          ? _value.isNewWallet
          : isNewWallet // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_WalletCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$_WalletCopyWith(_$_Wallet value, $Res Function(_$_Wallet) then) =
      __$$_WalletCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String label,
      @HiveField(2) String descriptor,
      @HiveField(3) String policy,
      @HiveField(4) int requiredPolicyElements,
      @HiveField(5) List<String> policyElements,
      @HiveField(6) String blockchain,
      @HiveField(7) List<Transaction> transactions,
      @HiveField(8) int balance,
      @HiveField(9) int lastAddressIndex,
      @HiveField(10) String walletType,
      @HiveField(11) bool isNewWallet});
}

/// @nodoc
class __$$_WalletCopyWithImpl<$Res> extends _$WalletCopyWithImpl<$Res>
    implements _$$_WalletCopyWith<$Res> {
  __$$_WalletCopyWithImpl(_$_Wallet _value, $Res Function(_$_Wallet) _then)
      : super(_value, (v) => _then(v as _$_Wallet));

  @override
  _$_Wallet get _value => super._value as _$_Wallet;

  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? descriptor = freezed,
    Object? policy = freezed,
    Object? requiredPolicyElements = freezed,
    Object? policyElements = freezed,
    Object? blockchain = freezed,
    Object? transactions = freezed,
    Object? balance = freezed,
    Object? lastAddressIndex = freezed,
    Object? walletType = freezed,
    Object? isNewWallet = freezed,
  }) {
    return _then(_$_Wallet(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      descriptor: descriptor == freezed
          ? _value.descriptor
          : descriptor // ignore: cast_nullable_to_non_nullable
              as String,
      policy: policy == freezed
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      requiredPolicyElements: requiredPolicyElements == freezed
          ? _value.requiredPolicyElements
          : requiredPolicyElements // ignore: cast_nullable_to_non_nullable
              as int,
      policyElements: policyElements == freezed
          ? _value._policyElements
          : policyElements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockchain: blockchain == freezed
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lastAddressIndex: lastAddressIndex == freezed
          ? _value.lastAddressIndex
          : lastAddressIndex // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: walletType == freezed
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      isNewWallet: isNewWallet == freezed
          ? _value.isNewWallet
          : isNewWallet // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'WalletClassAdapter')
class _$_Wallet extends _Wallet {
  const _$_Wallet(
      {@HiveField(0) this.id,
      @HiveField(1) required this.label,
      @HiveField(2) required this.descriptor,
      @HiveField(3) required this.policy,
      @HiveField(4) required this.requiredPolicyElements,
      @HiveField(5) required final List<String> policyElements,
      @HiveField(6) required this.blockchain,
      @HiveField(7) required final List<Transaction> transactions,
      @HiveField(8) required this.balance,
      @HiveField(9) required this.lastAddressIndex,
      @HiveField(10) required this.walletType,
      @HiveField(11) required this.isNewWallet})
      : _policyElements = policyElements,
        _transactions = transactions,
        super._();

  factory _$_Wallet.fromJson(Map<String, dynamic> json) =>
      _$$_WalletFromJson(json);

  @override
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  final String label;
  @override
  @HiveField(2)
  final String descriptor;
  @override
  @HiveField(3)
  final String policy;
  @override
  @HiveField(4)
  final int requiredPolicyElements;
  final List<String> _policyElements;
  @override
  @HiveField(5)
  List<String> get policyElements {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_policyElements);
  }

  @override
  @HiveField(6)
  final String blockchain;
  final List<Transaction> _transactions;
  @override
  @HiveField(7)
  List<Transaction> get transactions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @HiveField(8)
  final int balance;
  @override
  @HiveField(9)
  final int lastAddressIndex;
  @override
  @HiveField(10)
  final String walletType;
  @override
  @HiveField(11)
  final bool isNewWallet;

  @override
  String toString() {
    return 'Wallet(id: $id, label: $label, descriptor: $descriptor, policy: $policy, requiredPolicyElements: $requiredPolicyElements, policyElements: $policyElements, blockchain: $blockchain, transactions: $transactions, balance: $balance, lastAddressIndex: $lastAddressIndex, walletType: $walletType, isNewWallet: $isNewWallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Wallet &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality()
                .equals(other.descriptor, descriptor) &&
            const DeepCollectionEquality().equals(other.policy, policy) &&
            const DeepCollectionEquality()
                .equals(other.requiredPolicyElements, requiredPolicyElements) &&
            const DeepCollectionEquality()
                .equals(other._policyElements, _policyElements) &&
            const DeepCollectionEquality()
                .equals(other.blockchain, blockchain) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            const DeepCollectionEquality().equals(other.balance, balance) &&
            const DeepCollectionEquality()
                .equals(other.lastAddressIndex, lastAddressIndex) &&
            const DeepCollectionEquality()
                .equals(other.walletType, walletType) &&
            const DeepCollectionEquality()
                .equals(other.isNewWallet, isNewWallet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(descriptor),
      const DeepCollectionEquality().hash(policy),
      const DeepCollectionEquality().hash(requiredPolicyElements),
      const DeepCollectionEquality().hash(_policyElements),
      const DeepCollectionEquality().hash(blockchain),
      const DeepCollectionEquality().hash(_transactions),
      const DeepCollectionEquality().hash(balance),
      const DeepCollectionEquality().hash(lastAddressIndex),
      const DeepCollectionEquality().hash(walletType),
      const DeepCollectionEquality().hash(isNewWallet));

  @JsonKey(ignore: true)
  @override
  _$$_WalletCopyWith<_$_Wallet> get copyWith =>
      __$$_WalletCopyWithImpl<_$_Wallet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletToJson(this);
  }
}

abstract class _Wallet extends Wallet {
  const factory _Wallet(
      {@HiveField(0) final int? id,
      @HiveField(1) required final String label,
      @HiveField(2) required final String descriptor,
      @HiveField(3) required final String policy,
      @HiveField(4) required final int requiredPolicyElements,
      @HiveField(5) required final List<String> policyElements,
      @HiveField(6) required final String blockchain,
      @HiveField(7) required final List<Transaction> transactions,
      @HiveField(8) required final int balance,
      @HiveField(9) required final int lastAddressIndex,
      @HiveField(10) required final String walletType,
      @HiveField(11) required final bool isNewWallet}) = _$_Wallet;
  const _Wallet._() : super._();

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$_Wallet.fromJson;

  @override
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get label => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String get descriptor => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String get policy => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  int get requiredPolicyElements => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  List<String> get policyElements => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  String get blockchain => throw _privateConstructorUsedError;
  @override
  @HiveField(7)
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  @override
  @HiveField(8)
  int get balance => throw _privateConstructorUsedError;
  @override
  @HiveField(9)
  int get lastAddressIndex => throw _privateConstructorUsedError;
  @override
  @HiveField(10)
  String get walletType => throw _privateConstructorUsedError;
  @override
  @HiveField(11)
  bool get isNewWallet => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WalletCopyWith<_$_Wallet> get copyWith =>
      throw _privateConstructorUsedError;
}
