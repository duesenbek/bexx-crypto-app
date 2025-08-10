import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_study_guide/widgets/widgets.dart';
import 'package:flutter_study_guide/features/crypto_list/view/bloc/crypto_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final CryptoListBloc _cryptoListBloc =
      CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    super.initState();
    _cryptoListBloc.add(LoadCryptoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BexX Crypto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TalkerScreen(talker:GetIt.I<Talker>())
              ));
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: const Color(0xFF0C4C80),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          _cryptoListBloc.add(LoadCryptoList(completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoading) {
              return const Center(child: CircularProgressIndicator());
          } else if (state is CryptoListLoaded) {
            final coins = state.cryptoCoinsList;

            if (coins.isEmpty) {
              return const Center(child: Text("No crypto coins found"));
            }

            return ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              itemCount: coins.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 2.0,
              ),
              itemBuilder: (context, index) {
                final coin = coins[index];
                return CryptoCoinTile(
                  coinName: coin.name,
                  coinFullName: coin.name,
                  coinPrice: coin.priceInUSD,
                  cryptoIcon: coin.cryptoIcon ?? '',
                  coinSymbol: coin.coinSymbol ?? '',
                );
              },
            );
          } else if (state is CryptoListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () => _cryptoListBloc.add(LoadCryptoList()),
                    child: const Text('Retry',
                        style: TextStyle(fontSize: 16, color: Colors.blue)),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Unknown state"));
        },
      ),
    ),
    );
  }
}
