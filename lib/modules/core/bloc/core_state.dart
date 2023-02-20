part of 'core_bloc.dart';

abstract class CoreState extends Equatable {
  const CoreState({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  List<Object?> get props => [currentIndex];
}

class CoreInitial extends CoreState {
  const CoreInitial({super.currentIndex = 1});
}

class CoreFirstAccess extends CoreState {
  const CoreFirstAccess({
    super.currentIndex = 1,
    required this.pinController,
    required this.canAuthenticateWithBiometrics,
    required this.useFingerprintAuthentication,
  });

  final TextEditingController pinController;
  final bool canAuthenticateWithBiometrics;
  final bool useFingerprintAuthentication;

  @override
  List<Object?> get props =>
      super.props +
      [
        pinController,
        canAuthenticateWithBiometrics,
        useFingerprintAuthentication,
      ];
}

class CoreUnauthenticated extends CoreState {
  const CoreUnauthenticated({
    super.currentIndex = 1,
    required this.pinController,
    this.wrongPin = false,
    required this.canAuthenticateWithBiometrics,
    required this.useFingerprintAuthentication,
  });

  final bool wrongPin;
  final TextEditingController pinController;
  final bool canAuthenticateWithBiometrics;
  final bool useFingerprintAuthentication;

  @override
  List<Object?> get props =>
      super.props +
      [
        wrongPin,
        pinController,
        canAuthenticateWithBiometrics,
        useFingerprintAuthentication,
      ];
}

class CoreAuthenticated extends CoreState {
  const CoreAuthenticated({required super.currentIndex});
}

class CoreError extends CoreState {
  const CoreError({super.currentIndex = 1});
}
