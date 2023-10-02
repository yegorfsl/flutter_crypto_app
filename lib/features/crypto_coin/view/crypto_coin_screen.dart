import 'dart:developer';

import 'package:crypto_list_first_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoCoinBloc = CryptoCoinBloc(
    GetIt.I<AbstractCoinsRepository>()
  );

  late CryptoCoin coin = const CryptoCoin(name: 'name', priceInUSD: 1233, imageUrl: 'imageUrl');

  @override
  void initState() {
    _cryptoCoinBloc.add(LoadCryptoCoinDetails(coin: coin.name));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! CryptoCoin) {
      log('You must provide CryptoCoin args');
      return;
    }

    coin = args;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coin.name)),
    );
  }
}