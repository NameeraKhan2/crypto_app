import 'dart:convert';
import 'package:api_app/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_page.dart';
import 'favourite_list.dart';

class HomePage extends StatefulWidget {

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Currency> currencies;
  List<Currency> favouriteCurrencies=[];

  var isLoading =true;

  final List<MaterialColor> colors = [Colors.blue, Colors.indigo, Colors.amber];


  @override
  void initState() {
    getCurrencies();
    super.initState();
  }

  void getCurrencies() async{

    var headers = {
      'X-CMC_PRO_API_KEY': '1a02149b-fd1b-4814-b65e-68041bdd173c'
    };
    String cryptoURL= "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=10&convert=USD";
    http.Response response= await http.get(cryptoURL ,headers: headers);
    print(response.body);
    var res=jsonDecode(response.body);
    CryptoModel cryptoModel = CryptoModel.fromJson(res);
    currencies=cryptoModel.data;
    isLoading=false;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('CRYPTO APP'),
      ),
      body: _cryptoWidget(),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavouriteListPage(favouriteCurrencies)),
        );
      }, label: Text("Favourites")),
    );
  }
  

  Widget _cryptoWidget() {
    return  isLoading==true?Center(
      child: CircularProgressIndicator(),
    ) : Container(
      child:  Column(
        children: <Widget>[
           Flexible(
            child:  ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoDetailsPage(currencies[index])),
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
                                currencies[index].symbol,
                                //currencies[index].quote.usd.marketCap,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            if(currencies[index].isFavourite==false) {
                              currencies[index].isFavourite = true;
                              favouriteCurrencies.add(currencies[index]);
                            }else{
                              currencies[index].isFavourite = false;
                              favouriteCurrencies.remove(currencies[index]);
                            }
                            setState(() {
                            });

                           },
                            icon: currencies[index].isFavourite?Icon(Icons.favorite):Icon(Icons.favorite_outline)
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
