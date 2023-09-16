part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinEvent extends Equatable {
  const CryptoCoinEvent();
}

class LoadCryptoCoinDetails extends CryptoCoinEvent {
  const LoadCryptoCoinDetails({
    required this.coin
  });

  final String coin;

  @override
  List<Object?> get props => [coin];
}
