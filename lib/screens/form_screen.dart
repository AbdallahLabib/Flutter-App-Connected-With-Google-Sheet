import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Manager/product_manager.dart';
import 'package:task/model/product_model.dart';
import 'package:task/screens/list_screen.dart';
import 'package:task/services/constants.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //values
  String name;
  String email;
  String mobile;
  String modelNumber;
  String purchaseDate;

  void _submitForm(BuildContext context) {
    final managerProvider = Provider.of<Manager>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _showSnackBar('Submitting Form ...');

      ProductModel productModel = ProductModel(
        name: name,
        email: email,
        mobile: mobile,
        modelNumber: modelNumber,
        purchaseDate: purchaseDate,
      );

      managerProvider.insert(productModel);
    }
  }

  void _showSnackBar(message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      content: Container(
        height: 20,
        child: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  onWillPop() {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListScreen(
                  name: name,
                  email: email,
                  mobile: mobile,
                  modelNumber: modelNumber,
                  purchaseDate: purchaseDate,
                ),
              ),
            );
          },
          backgroundColor: KMainColor,
          child: Icon(
            Icons.next_plan,
            size: 52,
          ),
        ),
        key: _scaffoldKey,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 100.0, 20, 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        onEditingComplete: () => node.nextFocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: KCcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        onEditingComplete: () => node.nextFocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter e-mail';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter e-mail',
                          labelText: 'e-mail',
                          labelStyle: TextStyle(
                            color: KCcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                        onEditingComplete: () => node.nextFocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Mobile';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          labelText: 'Mobile number',
                          labelStyle: TextStyle(
                            color: KCcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            purchaseDate = value;
                          });
                        },
                        onEditingComplete: () => node.nextFocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Purchase Date';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Purchase Date',
                          labelText: 'Purchase Date',
                          labelStyle: TextStyle(
                            color: KCcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        onEditingComplete: () => node.unfocus(),
                        onChanged: (value) {
                          setState(() {
                            modelNumber = value;
                          });
                        },
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Model Number';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Model Number',
                          labelText: 'Model Number',
                          labelStyle: TextStyle(
                            color: KCcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: InkWell(
                          onTap: () => _submitForm(context),
                          child: Container(
                            width: size.width * .6,
                            height: size.width * .1,
                            decoration: BoxDecoration(
                                color: KCcolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
