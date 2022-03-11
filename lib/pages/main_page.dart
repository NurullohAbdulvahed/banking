import 'package:examui/models/banks_model.dart';
import 'package:examui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';


class MainPage extends StatefulWidget {
  static final String id = "MainPage";
   MainPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Banks> _list = [];
  bool isLoading = false;
  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      Log.d(response!),
      _showResponse(response),
    });
  }
  void _apiDelete(int id){
    setState(() {
      isLoading = true;
    });
    Network.DEL(Network.API_DELETE+id.toString(), Network.paramsEmpty()).then((response){
      Log.d(response!);
      _resPostDelete(response);
    });
  }

  void _resPostDelete(String response){
    setState(() {
      isLoading = false;
    });
    if(response != null)
      _apiPostList();
  }

  void _showResponse(String response) {
    List<Banks> list = Network.parsePostList(response);
    _list.clear();
    setState(() {
      isLoading = false;
      _list = list;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///APPBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 5,),
            Text(
              "Nurulloh",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/bella.jpg"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Create New Card
           _list.isNotEmpty ?  ListView.builder(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             itemCount: _list.length,
               itemBuilder: (context,index){

                 return Slidable(
                   key:  ValueKey(_list[index]),
                   endActionPane: ActionPane(
                     dismissible: DismissiblePane(onDismissed: () {
                       int _id = int.parse(_list[index].id!);
                       _apiDelete(_id);
                       setState(() {
                         _list.removeAt(index);
                       });

                     }),
                     motion: ScrollMotion(),
                     children: [
                     ],
                   ),
                   child: Column(
                     children: [
                       CreditCardWidget(
                         cardNumber: _list[index].cardNumber!,
                         expiryDate: _list[index].expiredDate!,
                         cardHolderName:_list[index].cardHolderName!,
                         cvvCode: _list[index].cvvCode!,
                         labelCardHolder: ("CARD HOLDER"),
                         labelExpiredDate: 'MM/YY',
                         showBackView: false,
                         isHolderNameVisible: true,
                         isSwipeGestureEnabled: true,
                         cardBgColor: Color(0xff1b447b),
                         cardType: CardType.visa,
                         customCardTypeIcons: <CustomCardTypeIcon>[
                           CustomCardTypeIcon(
                             cardType: CardType.visa,
                             cardImage: Image.asset(
                               'assets/images/visa.png',
                               height: 48,
                               width: 48,
                             ),
                           ),
                         ],
                         onCreditCardWidgetChange:(CreditCardBrand creditCardBrand) {

                         }),

                     ],
                   ),
                 );
               }
           )
              : SizedBox.shrink(),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.center_focus_strong),
                    onPressed: () async{
                      var result = await Navigator.of(context).pushNamed(HomePage.id);
                      if(result == true){
                        _apiPostList();
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  Text("Add new card",style: TextStyle(color: Colors.black,fontSize: 16),)
                ],
              ),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
            ),


          ],
        ),
      ),
    );
  }
}
