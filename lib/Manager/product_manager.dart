import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'package:task/model/product_model.dart';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-task-301809",
  "private_key_id": "e17205b76b8909560afe8bdbd4ce44f1018cdc1c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC2LNcEmYCroZQJ\nbg+n14arH1l64kkJyb59qXIkZzcd5SzM7owE5paY60O0+a/D2xVF/Xn0pgE9a4yk\nfhOqF8w0jqBeF4xfLPBJSzZi9H5Qs+xEYPlKP1TBYkEqsaRuAfby9ectrFxNJDck\nOGvu93IUbJpqFGnSoH2w9jHUTqSuJttp+JPraCCJrVfK03RNB3E8VC5bHnbTnlTR\nUqGw69SeF1naTIUwyfxvXObvVRrgruj9CfACBDWTXrtuwlvkoqsSUHebmlrUnl4u\n5hmVSX1Re+IREHl4Emc0BYaRPSvL2JxC46vBN2HfwpDhDOGRXAN3lD/pDQayJdzt\nPbyil0LfAgMBAAECggEAHs9+nhyIEn8FVoLyyuQ8tnxa2dmjmLAyM3aRA28hd0Dn\nTtGZhMqq9bn0fYstGubWtjukgKgC1ax24Osh0EauFsV4gfFhoEctbHf3/sxzAJst\nfnMYNmJ3py1C8EGTGbfjWDwWmTbpdXKGkO2p84SOGr4zb3V8YE8ccu1wiAO0/m7y\n5obfiA1qG5ufkGq0BrmDzHxi1j4PkCe7eJ18EW/rJuGZuRZs8m7HMGIQeaPNUBge\ndyLWbVCyFVLhAACUeMXyLka7NvpVxtltv7Q2ako+bghBx6nixpGILxJvwg4vsMnU\nJgKLkS4sknjUfcrqkh2h5dBnlE17sV+09rGFVQe/oQKBgQDbLhFAIz+ZGFIL1WQ0\ntno4j9JcAJ2orwyC1E5viPesd8vSXl4sWoyRO8tLR6GyXPIUdzHlD/if3mgAmP15\nYKS0o4clkLT9MO5AFMssM2oQCDrqaEUZRykLVfciKNyDZf/dti87y0MBQXI+TH+b\nmkp0LLXnIITiFZhUf3vASf8R+wKBgQDUx11ZKj/x8IgHxwE1Be7QgmAGNqMJ3XL4\n3+SVlnJvIRqktUyIfOjZQHlKdINMtYAS5nLv33788nhiof8rSLeWzwfsYQ5GbF4Q\nxbZFRoLutjTeiEhRHyqcnZpiFjO32ZIMP97OSuiyRa8KpNNLBcDQh4M4/IUv0Qqp\nQzP9Hl3hbQKBgCEmPoWszxmgjAguJhGy55lWZ0Jy9WVl1EaVRaeo14zGMZWHoEal\nC02L9ZtVIieP1y0xOeKjH79OK/yrJusMqtyHPxF3aWhB1kbq3i+5NvllxUNesdS4\n5oRIZDBObcuRybkGrO4mN+Qgud6iQ0qNc2VOvdRPHsny6i8deOIETwexAoGALnNT\nYprBmOycla4RCmVALE657cFRuF6asdAW070jQDVm3pwhmA5EuuDDWcizvTRGQFoE\nr28IBupb85RP40AdrBOINEc/2YngwyKWVus8vCYUxpvTxbnbEJOrV0xnf/REWN48\noqZhxEFIJDe1VMRtwlhDAlbGMJkfDbJ5EAHoFsUCgYBEZqaVoXwq0XwZ4qnwbpRB\nyAZ2u+pJ7LaQym9Z4fxT8R2eTFlbeeKxsD31Vyrsm+/38OwL5bIj89NbcyyC2AJA\nWxKB8DmqfTb29e6JVvXnu/Ga3x/e8yz3zix+udSaN5yLjaWpS0XUsMyEOoyOCv3y\nrGZ9cDteYpZN/ZhhG9bFLA==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-task@flutter-task-301809.iam.gserviceaccount.com",
  "client_id": "113783861818322705285",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-task%40flutter-task-301809.iam.gserviceaccount.com"

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
