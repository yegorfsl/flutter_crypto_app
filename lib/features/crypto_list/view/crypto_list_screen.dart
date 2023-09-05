import 'dart:async';

import 'package:crypto_list_first_app/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_list_first_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_list_first_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
      GetIt.I<AbstractCoinsRepository>()
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Crypto List')),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: state.coinsList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, i) {
                      final coin = state.coinsList[i];
                      return CryptoCoinTile(coin: coin);
                    }
                );
              }
              if (state is CryptoListLoadingFailure) {
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
                              _cryptoListBloc.add(LoadCryptoList());
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
        ),
    );
  }
}