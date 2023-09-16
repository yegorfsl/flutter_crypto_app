import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  final AbstractCoinsRepository coinsRepository;

  CryptoCoinBloc(this.coinsRepository) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoinDetails>((event, emit) async {
      try {
        if (state is! CryptoCoinLoaded) {
          emit(CryptoCoinLoading());
        }

        final coin = await coinsRepository.getCoinDetails(event.coin);
        emit(CryptoCoinLoaded(coin: coin));
      } catch (e) {
        emit(CryptoCoinLoadingFailure(exception: e));
      }
    });
  }
}
