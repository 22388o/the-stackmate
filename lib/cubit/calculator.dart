import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petitparser/petitparser.dart';
import 'package:sats/api/interface/coincap.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/rate.dart';
import 'package:sats/pkg/interface/vibrate.dart';
import 'package:sats/pkg/validation.dart';

part 'calculator.freezed.dart';

@freezed
class CalculatorState with _$CalculatorState {
  const factory CalculatorState({
    @Default(false) bool btcSelected,
    Rate? selectedRate,
    @Default('0') String currencyAmt,
    @Default('0') String satsAmt,
    @Default(true) bool editingBtc,
    List<Rate>? rates,
    @Default(false) bool loadingRates,
    @Default('') String loadingRatesError,
  }) = _CalculatorState;
}

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(
    this._logger,
    this._vibrate,
    this._ratesAPI,
  ) : super(const CalculatorState()) {
    getRates();
  }

  final Logger _logger;
  final IVibrate _vibrate;
  final IRatesAPI _ratesAPI;

  void getRates() async {
    try {
      emit(state.copyWith(loadingRates: true));

      final usdResp = await _ratesAPI.getRate(symbol: 'usd');
      if (usdResp.hasError) {
        emit(
          state.copyWith(
            loadingRates: false,
            loadingRatesError: usdResp.error!,
          ),
        );
        return;
      }

      final inrResp = await _ratesAPI.getRate(symbol: 'inr');
      if (inrResp.hasError) {
        emit(
          state.copyWith(
            loadingRates: false,
            loadingRatesError: inrResp.error!,
          ),
        );
        return;
      }

      final usd = Rate(
        symbol: 'USD',
        name: 'U.S. Dollar',
        rate: usdResp.result!,
      );

      final inr = Rate(
        symbol: 'INR',
        name: 'Indian Ruppee',
        rate: inrResp.result!,
      );

      final rates = [usd, inr];

      await Future.delayed(const Duration(seconds: 1));
      emit(
        CalculatorState(
          rates: rates,
          selectedRate: rates[1],
          editingBtc: false,
          btcSelected: false,
          currencyAmt: '',
          satsAmt: '',
          loadingRates: false,
        ),
      );
      calcKeyPressed('1');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapGetRates', s);
      emit(
        state.copyWith(
          loadingRates: false,
          loadingRatesError: 'Error Occured. Please try again.',
        ),
      );
    }
  }

  void fieldSelected(bool isFiat) async {
    calcKeyPressed('=');
    await Future.delayed(const Duration(microseconds: 10));
    emit(state.copyWith(editingBtc: !isFiat));
  }

  void currencyTypeChanged(Rate rate) async {
    if (rate.symbol == state.selectedRate!.symbol) return;

    try {
      calcKeyPressed('C');
      await Future.delayed(const Duration(microseconds: 100));

      emit(
        state.copyWith(
          selectedRate: rate,
          editingBtc: false,
        ),
      );
      await Future.delayed(const Duration(microseconds: 100));
      calcKeyPressed('1');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCurrencyTypeChanged', s);
    }
  }

  void btcTypeChanged(bool isBtc) async {
    if (isBtc && state.btcSelected) return;
    if (!isBtc && !state.btcSelected) return;
    try {
      calcKeyPressed('C');
      await Future.delayed(const Duration(microseconds: 100));

      emit(
        state.copyWith(
          btcSelected: isBtc,
          editingBtc: false,
        ),
      );
      await Future.delayed(const Duration(microseconds: 100));
      calcKeyPressed('1');
      await Future.delayed(const Duration(microseconds: 100));
      emit(state.copyWith(editingBtc: true));
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapBtcTypeChanged', s);
    }
  }

  void calcKeyPressed(String key) async {
    vibrate();
    try {
      switch (key) {
        case 'C':
          emit(state.copyWith(satsAmt: '0', currencyAmt: '0'));
          return;

        case 'del':
          if (state.editingBtc) {
            final current = state.satsAmt;
            final removeLast = current.substring(0, current.length - 1);
            emit(state.copyWith(satsAmt: removeLast));
          } else {
            final current = state.currencyAmt;
            final removeLast = current.substring(0, current.length - 1);
            emit(state.copyWith(currencyAmt: removeLast));
          }

          break;

        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        case '(':
        case ')':
        case '+':
        case '-':
        case 'x':
        case '/':
        case '.':
          String str = '';
          if (state.editingBtc) {
            if (!state.btcSelected && key == '.') return;
            str = _isZero(state.satsAmt) ? '' : state.satsAmt;
            final newExp = str + (key == 'x' ? '*' : key);
            emit(
              state.copyWith(
                satsAmt:
                    state.btcSelected ? newExp : Validation.addCommas(newExp),
              ),
            );
          } else {
            if ('.'.allMatches(state.currencyAmt).length == 1 && key == '.')
              return;
            str = _isZero(state.currencyAmt) ? '' : state.currencyAmt;
            final newExp = str + (key == 'x' ? '*' : key);
            emit(state.copyWith(currencyAmt: Validation.addCommas(newExp)));
          }

          break;

        case '=':
          final parser = _expBuilder().build().end();
          String calc = '';

          if (state.editingBtc)
            calc = state.satsAmt;
          else
            calc = state.currencyAmt;

          if (calc.startsWith('.')) calc = '0' + calc;
          for (var i = 0; i < calc.length; i++)
            if (calc[i] == '.' && !Validation.isNumeric(calc[i - 1]))
              calc =
                  calc.substring(0, i) + '0' + calc.substring(i, calc.length);

          calc = parser.parse(calc).value.toString();

          if (state.editingBtc)
            emit(state.copyWith(satsAmt: calc));
          else
            emit(state.copyWith(currencyAmt: calc));

          break;
      }
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCalcKeyPressed1', s);
      emit(state.copyWith(satsAmt: '0', currencyAmt: '0'));
    }

    await Future.delayed(const Duration(microseconds: 100));
    _afterCalcChanged();
  }

  void _afterCalcChanged() {
    try {
      final parser = _expBuilder().build().end();

      String calc = '';
      if (state.editingBtc) {
        calc = Validation.removeCommas(state.satsAmt);
      } else {
        calc = Validation.removeCommas(state.currencyAmt);
      }

      if (calc.startsWith('.')) calc = '0' + calc;

      for (var i = 0; i < calc.length; i++)
        if (calc[i] == '.' && !Validation.isNumeric(calc[i - 1]))
          calc = calc.substring(0, i) + '0' + calc.substring(i, calc.length);

      if (calc == '') return;
      // if (calc.split('.').length > 1) return;

      print('---calc: $calc');
      if (!calc.endsWith('.')) calc = parser.parse(calc).value.toString();
      // calc = calc.substring(0, calc.length - 1);

      if (state.editingBtc) {
        late double amt;
        // if (calc.endsWith('.'))
        amt = double.parse(Validation.removeCommas(calc));
        // else
        // amt = 0;
        final finalVal = (state.btcSelected ? amt : amt / 100000000) *
            state.selectedRate!.rate;
        emit(
          state.copyWith(
            currencyAmt: Validation.addCommas(
              finalVal.toStringAsFixed(2),
            ),
          ),
        );
      } else {
        late double amt;
        // if (calc.endsWith('.'))
        amt = double.parse(Validation.removeCommas(calc));
        // else
        // amt = 0;

        final finalVal = amt / state.selectedRate!.rate;

        emit(
          state.copyWith(
            satsAmt: state.btcSelected
                ? finalVal.toStringAsFixed(8)
                : Validation.addCommas(
                    (finalVal * 100000000).toStringAsFixed(0),
                  ),
          ),
        );
      }
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCalcKeyPressed2', s);
      print('e2:::' + e.toString());
      if (state.editingBtc)
        emit(state.copyWith(currencyAmt: ''));
      else
        emit(state.copyWith(satsAmt: ''));
    }
  }

  bool _isZero(String val) {
    try {
      if (val == '') return true;
      final amt = double.parse(val.replaceAll(',', ''));
      return amt == 0 && !val.contains('.');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._isZero', s);
    }
    return false;
  }

  void vibrate() {
    try {
      _vibrate.vibe();
    } catch (e, s) {
      _logger.logException(e, 'CalcKey._vibrateOnClicked', s);
    }
  }
}

ExpressionBuilder _expBuilder() {
  final builder = ExpressionBuilder();
  // ignore: avoid_single_cascade_in_expression_statements
  builder.group()
    ..primitive(
      digit()
          .plus()
          .seq(char('.').seq(digit().plus()).optional())
          .flatten()
          .trim()
          .map((a) => num.tryParse(a)),
    );

  return builder;
}
