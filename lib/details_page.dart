import 'package:api_app/crypto_model.dart';
import 'package:flutter/material.dart';

class CryptoDetailsPage extends StatelessWidget {

  final Currency currency;

  CryptoDetailsPage(this.currency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12.0),

            child: Text(currency.name),
          ),
          Container(
            margin: EdgeInsets.all(15.0),

            child: Text(currency.symbol),
          ),
          Container(
            margin: EdgeInsets.all(12.0),

            child: Text(currency.quote.usd.marketCap.toString()),
          ),
          Container(
            margin: EdgeInsets.all(15.0),

            child: Text(currency.quote.usd.percentChange24H.toString()),
          ),
        ],
      ),
    );
  }
}
