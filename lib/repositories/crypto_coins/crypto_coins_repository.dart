import 'package:crypto_list_first_app/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,AID,AOA,SOL,CAG,DOV&tsyms=USD"
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final parsedData = dataRaw.entries
        .map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
      name: e.key,
      priceInUSD: price,
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      );
    }).toList();

    return parsedData;
  }
}