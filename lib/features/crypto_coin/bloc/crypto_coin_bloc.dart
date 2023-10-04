import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
      } catch (e, st) {
        emit(CryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
