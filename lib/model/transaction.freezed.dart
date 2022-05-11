// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  _Transaction call(
      {@HiveField(0) required int timestamp,
      @HiveField(1) required int height,
      @HiveField(2) required int confirmation_time,
      @HiveField(3) required String txid,
      @HiveField(4) required int received,
      @HiveField(5) required int sent,
      @HiveField(6) required int fee}) {
    return _Transaction(
      timestamp: timestamp,
      height: height,
      confirmation_time: confirmation_time,
      txid: txid,
      received: received,
      sent: sent,
      fee: fee,
    );
  }

  Transaction fromJson(Map<String, Object> json) {
    return Transaction.fromJson(json);
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  @HiveField(0)
  int get timestamp => throw _privateConstructorUsedError;
  @HiveField(1)
  int get height => throw _privateConstructorUsedError;
  @HiveField(2)
  int get confirmation_time => throw _privateConstructorUsedError;
  @HiveField(3)
  String get txid => throw _privateConstructorUsedError;
  @HiveField(4)
  int get received => throw _privateConstructorUsedError;
  @HiveField(5)
  int get sent => throw _privateConstructorUsedError;
  @HiveField(6)
  int get fee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int timestamp,
      @HiveField(1) int height,
      @HiveField(2) int confirmation_time,
      @HiveField(3) String txid,
      @HiveField(4) int received,
      @HiveField(5) int sent,
      @HiveField(6) int fee});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? height = freezed,
    Object? confirmation_time = freezed,
    Object? txid = freezed,
    Object? received = freezed,
    Object? sent = freezed,
    Object? fee = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      confirmation_time: confirmation_time == freezed
          ? _value.confirmation_time
          : confirmation_time // ignore: cast_nullable_to_non_nullable
              as int,
      txid: txid == freezed
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      received: received == freezed
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as int,
      sent: sent == freezed
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) then) =
      __$TransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int timestamp,
      @HiveField(1) int height,
      @HiveField(2) int confirmation_time,
      @HiveField(3) String txid,
      @HiveField(4) int received,
      @HiveField(5) int sent,
      @HiveField(6) int fee});
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(
      _Transaction _value, $Res Function(_Transaction) _then)
      : super(_value, (v) => _then(v as _Transaction));

  @override
  _Transaction get _value => super._value as _Transaction;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? height = freezed,
    Object? confirmation_time = freezed,
    Object? txid = freezed,
    Object? received = freezed,
    Object? sent = freezed,
    Object? fee = freezed,
  }) {
    return _then(_Transaction(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      confirmation_time: confirmation_time == freezed
          ? _value.confirmation_time
          : confirmation_time // ignore: cast_nullable_to_non_nullable
              as int,
      txid: txid == freezed
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      received: received == freezed
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as int,
      sent: sent == freezed
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'TransactionClassAdapter')
class _$_Transaction extends _Transaction {
  const _$_Transaction(
      {@HiveField(0) required this.timestamp,
      @HiveField(1) required this.height,
      @HiveField(2) required this.confirmation_time,
      @HiveField(3) required this.txid,
      @HiveField(4) required this.received,
      @HiveField(5) required this.sent,
      @HiveField(6) required this.fee})
      : super._();

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  @override
  @HiveField(0)
  final int timestamp;
  @override
  @HiveField(1)
  final int height;
  @override
  @HiveField(2)
  final int confirmation_time;
  @override
  @HiveField(3)
  final String txid;
  @override
  @HiveField(4)
  final int received;
  @override
  @HiveField(5)
  final int sent;
  @override
  @HiveField(6)
  final int fee;

  @override
  String toString() {
    return 'Transaction(timestamp: $timestamp, height: $height, confirmation_time: $confirmation_time, txid: $txid, received: $received, sent: $sent, fee: $fee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Transaction &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.confirmation_time, confirmation_time) ||
                const DeepCollectionEquality()
                    .equals(other.confirmation_time, confirmation_time)) &&
            (identical(other.txid, txid) ||
                const DeepCollectionEquality().equals(other.txid, txid)) &&
            (identical(other.received, received) ||
                const DeepCollectionEquality()
                    .equals(other.received, received)) &&
            (identical(other.sent, sent) ||
                const DeepCollectionEquality().equals(other.sent, sent)) &&
            (identical(other.fee, fee) ||
                const DeepCollectionEquality().equals(other.fee, fee)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(confirmation_time) ^
      const DeepCollectionEquality().hash(txid) ^
      const DeepCollectionEquality().hash(received) ^
      const DeepCollectionEquality().hash(sent) ^
      const DeepCollectionEquality().hash(fee);

  @JsonKey(ignore: true)
  @override
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(this);
  }
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {@HiveField(0) required int timestamp,
      @HiveField(1) required int height,
      @HiveField(2) required int confirmation_time,
      @HiveField(3) required String txid,
      @HiveField(4) required int received,
      @HiveField(5) required int sent,
      @HiveField(6) required int fee}) = _$_Transaction;
  const _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override
  @HiveField(0)
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  int get height => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  int get confirmation_time => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String get txid => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  int get received => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  int get sent => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  int get fee => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionCopyWith<_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
