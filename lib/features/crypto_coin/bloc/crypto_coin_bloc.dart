import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc() : super(CryptoCoinInitial()) {
    on<CryptoCoinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
