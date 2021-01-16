import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Manager/product_manager.dart';
import 'package:task/model/product_model.dart';
import 'package:task/services/constants.dart';

class ListScreen extends StatelessWidget {
  //values
  final String name;
  final String email;
  final String mobile;
  final String modelNumber;
  final String purchaseDate;

  ListScreen({
    this.name,
    this.email,
    this.mobile,
    this.modelNumber,
    this.purchaseDate,
  });

  @override
  Widget build(BuildContext context) {
    final managerProvider = Provider.of<Manager>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Product List',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: managerProvider?.getAll(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>> snapshot) {
                  List<ProductModel> data = snapshot?.data;
                  final _nameList = data?.map((e) => e.name)?.toList() ?? [];
                  final _emailList = data?.map((e) => e.email)?.toList() ?? [];
                  final _mobileList =
                      data?.map((e) => e.mobile)?.toList() ?? [];
                  final _purchaseDateList =
                      data?.map((e) => e.purchaseDate)?.toList() ?? [];
                  final _modelNumberList =
                      data?.map((e) => e.modelNumber)?.toList() ?? [];
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      return ListView.builder(
                        itemCount: _nameList.length,
                        itemBuilder: (context, i) {
                          return Dismissible(
                            key: ValueKey(_nameList[i]),
                            direction: DismissDirection.endToStart,
                            onDismissed: (value) {
                              managerProvider.deleteById(_nameList[i]);
                            },
                            background: Container(
                              color: Colors.red[600],
                              child: Icon(
                                Icons.delete,
                                size: 60,
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: KCcolor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Product #${i + 1} Description',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Name: ${_nameList[i] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'e-mail: ${_emailList[i] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Mobile: ${_mobileList[i] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Purchase Date: ${_purchaseDateList[i] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Model Number: ${_modelNumberList[i] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
