import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';

part 'core_event.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  CoreBloc() : super(const CoreInitial()) {
    on<NavigationBarItemPressed>((event, emit) {
      _currentIndex = event.newIndex;
      emit(CoreAuthenticated(currentIndex: _currentIndex));
    });
    on<GetPixBoxFailed>((event, emit) {
      emit(const CoreError());
    });
    on<FirstAccess>((event, emit) {
      emit(_getFirstAccessState());
    });
    on<RequestUserPin>((event, emit) {
      emit(_getUnauthenticatedState());
    });
    on<PinChanged>((event, emit) {
      int? pinNumber = int.tryParse(event.pin);
      if (pinNumber != null && event.pin.length == 6) {
        emit(const CoreInitial());
        _checkPin(enteredPin: pinNumber);
      }
    });
    on<UserAuthenticated>((event, emit) {
      emit(CoreAuthenticated(currentIndex: _currentIndex));
    });
    on<WrongPinEntered>((event, emit) {
      emit(_getUnauthenticatedState(wrongPin: true));
    });
    on<AllowFingerprintToggled>((event, emit) {
      _useFingerprintAuthentication = event.value;
      emit(_getFirstAccessState());
    });
    on<FingerprintIconTapped>((event, emit) {
      emit(const CoreInitial());
      _authenticateWithBiometrics();
    });
    on<RetryTapped>((event, emit) {
      emit(const CoreInitial());
      _checkAuth();
    });

    _checkAuth();
  }

  int _currentIndex = 0;
  final TextEditingController _pinController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  bool _canAuthenticateWithBiometrics = false;
  bool _useFingerprintAuthentication = true;

  Future<void> _checkAuth() async {
    try {
      _canAuthenticateWithBiometrics =
          await _auth.isDeviceSupported() && await _auth.canCheckBiometrics;
      int? pin = await HiveConfig.getUserPin();
      if (pin == null) {
        add(FirstAccess());
      } else {
        _useFingerprintAuthentication =
            await HiveConfig.getUseFingerprintAuth();
        add(RequestUserPin());
      }
    } catch (e) {
      log(e.toString());
      add(GetPixBoxFailed());
    }
  }

  Future<void> _checkPin({required int enteredPin}) async {
    try {
      int? pin = await HiveConfig.getUserPin();
      if (pin == null) {
        await HiveConfig.saveUserPin(enteredPin);
        await HiveConfig.saveUseFingerprintAuth(
          _useFingerprintAuthentication,
        );

        if (_useFingerprintAuthentication) {
          final bool didAuthenticate = await _auth.authenticate(
            localizedReason: 'Please authenticate to sign in',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (didAuthenticate) {
            add(UserAuthenticated());
          } else {
            await HiveConfig.saveUseFingerprintAuth(false);
            add(UserAuthenticated());
          }
        } else {
          add(UserAuthenticated());
        }
      } else if (pin == enteredPin) {
        add(UserAuthenticated());
      } else {
        _pinController.clear();
        add(WrongPinEntered());
      }
    } catch (e) {
      log(e.toString());
      add(GetPixBoxFailed());
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to sign in',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        add(UserAuthenticated());
      } else {
        add(RequestUserPin());
      }
    } catch (e) {
      log(e.toString());
      add(RequestUserPin());
    }
  }

  CoreUnauthenticated _getUnauthenticatedState({bool wrongPin = false}) {
    return CoreUnauthenticated(
      pinController: _pinController,
      canAuthenticateWithBiometrics: _canAuthenticateWithBiometrics,
      useFingerprintAuthentication: _useFingerprintAuthentication,
      wrongPin: wrongPin,
    );
  }

  CoreFirstAccess _getFirstAccessState() {
    return CoreFirstAccess(
      pinController: _pinController,
      canAuthenticateWithBiometrics: _canAuthenticateWithBiometrics,
      useFingerprintAuthentication: _useFingerprintAuthentication,
    );
  }
}
