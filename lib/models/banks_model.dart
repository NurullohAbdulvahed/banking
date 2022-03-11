// To parse this JSON data, do
//
//     final banks = banksFromJson(jsonString);

import 'dart:convert';

List<Banks> banksFromJson(String str) => List<Banks>.from(json.decode(str).map((x) => Banks.fromJson(x)));

String banksToJson(List<Banks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banks {
  Banks({
   this.cardNumber,
   this.expiredDate,
   this.cvvCode,
   this.cardHolderName,
   this.id,
  });

  String? cardNumber;
  String? expiredDate;
  String? cvvCode;
  String? cardHolderName;
  String? id;

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
    cardNumber: json["cardNumber"],
    expiredDate: json["expiredDate"],
    cvvCode: json["cvvCode"],
    cardHolderName: json["cardHolderName"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cardNumber": cardNumber,
    "expiredDate": expiredDate,
    "cvvCode": cvvCode,
    "cardHolderName": cardHolderName,
    "id": id,
  };
}