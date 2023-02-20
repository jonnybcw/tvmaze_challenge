part of 'core_bloc.dart';

abstract class CoreEvent extends Equatable {
  const CoreEvent();

  @override
  List<Object?> get props => [];
}

class NavigationBarItemPressed extends CoreEvent {
  const NavigationBarItemPressed({required this.newIndex});

  final int newIndex;

  @override
  List<Object?> get props => [newIndex];
}

class GetPixBoxFailed extends CoreEvent {}

class FirstAccess extends CoreEvent {}

class RequestUserPin extends CoreEvent {}

class PinChanged extends CoreEvent {
  const PinChanged({required this.pin});

  final String pin;

  @override
  List<Object?> get props => [pin];
}

class UserAuthenticated extends CoreEvent {}

class WrongPinEntered extends CoreEvent {}

class AllowFingerprintToggled extends CoreEvent {
  const AllowFingerprintToggled({required this.value});

  final bool value;

  @override
  List<Object?> get props => [value];
}

class FingerprintIconTapped extends CoreEvent {}

class RetryTapped extends CoreEvent {}
