import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_manager/models/currency.dart';

class ApiProvider {
  Future<Currency> currencydata() async{
    http.Response response = await http.get(
        'http://forex.cbm.gov.mm/api/latest');

    var c = jsonDecode(response.body);
    Currency res = Currency.fromJson(c);
    return res;
  }
}