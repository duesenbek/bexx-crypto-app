import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';


class CryptoCoinScreen extends StatefulWidget {
  final CryptoCoinBloc cryptoCoinBloc;

  const CryptoCoinScreen({
    super.key,
    required this.cryptoCoinBloc,
  });

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  String? coinIcon;
  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
      coinName = args?['coinName'] ?? 'Unknown Coin';
      coinIcon = args?['coinIcon'] ?? '';

      if (coinName != null && coinName!.isNotEmpty && coinName != 'Unknown Coin') {
        widget.cryptoCoinBloc.add(LoadCryptoCoin(coinName!));
        _hasLoaded = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C4C80),
        title: Row(
          children: [
            if (coinIcon != null && coinIcon!.isNotEmpty)
              Image.network(
                coinIcon!,
                width: 40.0,
                height: 40.0,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 40.0, color: Colors.white);
                },
              ),
            const SizedBox(width: 8.0),
            Text(
              coinName ?? 'Unknown Coin',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: widget.cryptoCoinBloc,
        builder: (context, state) {
          if (state is CryptoCoinLoaded) {
            final details = state.coin.details;

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (details.cryptoIcon != null)
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.network(
                        'https://www.cryptocompare.com${details.cryptoIcon!}',
                        fit: BoxFit.contain,
                      ),
                    )
                  else
                    const SizedBox(
                      height: 160,
                      width: 160,
                      child: Icon(
                        Icons.error,
                        size: 100.0,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    details.cryptoFullName ?? details.symbol,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '\$${details.priceInUSD.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        _DataRow(
                          title: 'Market Cap',
                          value: '\$${details.marketCap.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 6),
                        _DataRow(
                          title: 'Volume 24h',
                          value: '\$${details.volume24h.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                  BaseCard(
                    child: _DataRow(
                      title: '24h Change',
                      value: '${details.change24h.toStringAsFixed(2)}%',
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CryptoCoinError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Ошибка: ${state.message}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
