import 'package:crypto_list_first_app/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:crypto_list_first_app/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinList;

  @override
  void initState() {
    _loadCryptoCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Crypto List')),
        body: (_cryptoCoinList == null)
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            itemCount: _cryptoCoinList!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, i) {
              final coin = _cryptoCoinList![i];
              return CryptoCoinTile(coin: coin);
            }
        ),
    );
  }

  Future<void> _loadCryptoCoin() async {
    _cryptoCoinList = await CryptoCoinsRepository().getCoinsList();
    setState(() {});
  }
}