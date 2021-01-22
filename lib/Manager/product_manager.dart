import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'package:task/model/product_model.dart';

//To get your credentials please follow that link
//https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": ""

}
''';

// your spreadsheet id
const _spreadsheetId = '1jpNG8Z9c8EO-JZtMGs2_u5oYQSpBG5XD52lVsY5kW_I';

class Manager with ChangeNotifier {
  final GSheets _gSheets = GSheets(_credentials);
  Spreadsheet _spreadsheet;
  Worksheet _productSheet;

  Future<void> init() async {
    _spreadsheet ??= await _gSheets.spreadsheet(_spreadsheetId);
    _productSheet ??= _spreadsheet.worksheetByTitle('users');
  }

  Future<List<ProductModel>> getAll() async {
    await init();
    final products = await _productSheet.values.map.allRows();
    var list = products.map((json) => ProductModel.fromGsheet(json)).toList();
    print('Length of Row List with values ::::::::::  ${list.length}');
    return list;
  }

  Future<ProductModel> getById(String name) async {
    await init();
    final map = await _productSheet.values.map.rowByKey(
      name,
      fromColumn: 1,
    );
    return map == null ? null : ProductModel.fromGsheet(map);
  }

  Future<bool> insert(ProductModel product) async {
    await init();
    return _productSheet.values.map.insertRowByKey(
      product.name,
      product.toGsheet(),
      fromColumn: 1,
      appendMissing: true,
    );
    //notifyListeners();
  }

  Future<bool> deleteById(String name) async {
    await init();
    final index = await _productSheet.values.rowIndexOf(name);
    if (index > 0) {
      return _productSheet.deleteRow(index);
    }
    return false;
  }

  Future<bool> delete(ProductModel product) => deleteById(product.name);
}
