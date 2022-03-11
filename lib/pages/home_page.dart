import 'package:examui/models/banks_model.dart';
import 'package:examui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:http/http.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "MainPage";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cardNumber = '';
  Banks? banks;
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    
    super.initState();
  }

  void goToMainPage(){
    Banks banks = Banks(expiredDate: expiryDate, cardHolderName: cardHolderName, cardNumber: cardNumber, cvvCode: cvvCode,);
    Network.POST(Network.API_CREATE, Network.paramsCreate(banks))
        .then((response) {
      Log.d(response!);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///appbar
      appBar: AppBar(
        elevation: 0,
        title: Text("Add your card",style: TextStyle(color: Colors.black),),

        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Fill in the fields below or use camera phone"),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 20),
                    ),
                    CreditCardForm(
                        cardNumber: cardNumber,
                        ///CardNumberDecoration
                        cardNumberDecoration: InputDecoration(
                            labelText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "assets/images/mastercard.png",
                                  width: 30,
                                  height: 30,
                                ))),
                        expiryDate: expiryDate,

                        ///ExpiryDecoration
                        expiryDateDecoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),

                        ///cardHolderDecoration

                        cardHolderDecoration:  InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Card Holder',
                        ),
                        cardHolderName: cardHolderName,


                        ///CVVCodeDecoration
                        cvvCodeDecoration:  InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cvvCode: cvvCode,

                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.blue,
                        formKey: formKey),
                    MaterialButton(
                      shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: (){
                          goToMainPage();
                          setState(() {});
                          Navigator.of(context).pop(true);
                        },
                      child: Text("ADD"),

                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

