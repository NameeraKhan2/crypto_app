import 'dart:convert';
import 'package:api_app/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_page.dart';
import 'favourite_list.dart';

class FavouriteListPage extends StatefulWidget {

  final List<Currency> favouriteCurrencies;
  FavouriteListPage(this.favouriteCurrencies);

  @override
  _FavouriteListPageState createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {

  final List<MaterialColor> colors = [Colors.blue, Colors.indigo, Colors.amber];



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Favourite List'),
      ),
      body: _cryptoWidget(),
    );
  }


  Widget _cryptoWidget() {
    return Container(
      child:  Column(
        children: <Widget>[
          Flexible(
            child:  ListView.builder(
              itemCount: widget.favouriteCurrencies.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoDetailsPage(widget.favouriteCurrencies[index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue[300],
                      width: double.infinity,
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.favouriteCurrencies[index].symbol,
                                //currencies[index].quote.usd.marketCap,
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.amber));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.green));
    }
    return RichText(
      text:
      new TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
