import 'dart:developer';

import 'package:crypto_list_first_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_list_first_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key
    // required this.coin,
  });

  // final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoCoinBloc = CryptoCoinBloc(
    GetIt.I<AbstractCoinsRepository>()
  );

  late CryptoCoin coin = const CryptoCoin(name: 'BTC', priceInUSD: 1233, imageUrl: 'imageUrl');

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
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _cryptoCoinBloc,
        builder: (context, state) {
          if (state is CryptoCoinLoaded) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(coin.imageUrl),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 35),
                      Text(
                        coin.name,
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        '${coin.priceInUSD} \$',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            );
          }
          if (state is CryptoCoinLoadingFailure) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Oops, something went wrong =(',
                        style: darkTheme.textTheme.headlineMedium
                    ),
                    Text(
                        'Please, try again later',
                        style: darkTheme.textTheme.labelSmall?.copyWith(fontSize: 16)
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                        onPressed: () {
                          _cryptoCoinBloc.add(LoadCryptoCoinDetails(coin: coin.name));
                        },
                        child: const Text('Try again')
                    )
                  ],
                )
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}