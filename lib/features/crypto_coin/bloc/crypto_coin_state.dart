part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState extends Equatable {
  const CryptoCoinState();
}

class CryptoCoinInitial extends CryptoCoinState {
  @override
  List<Object> get props => [];
}
