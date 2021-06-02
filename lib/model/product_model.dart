/// FeedbackForm is a data class which stores data fields of Feedback.
class ProductModel {
  //final String id;
  final String name;
  final String email;
  final String mobile;
  final String modelNumber;
  final String purchaseDate;
  ProductModel({
    //this.id,
    this.name,
    this.email,
    this.mobile,
    this.modelNumber,
    this.purchaseDate,
  });

  @override
  String toString() =>
      'FormModel{Name : $name, e-mail:$email, Mobile:$mobile, Model Number:$modelNumber, Purchase Date:$purchaseDate}';

  factory ProductModel.fromGsheet(Map<String, dynamic> json) {
    return ProductModel(
      name: json['Name'],
      email: json['e-mail'],
      mobile: json['Mobile'],
      modelNumber: json['Model Number'],
      purchaseDate: json['Purchase Date'],
    );
  }

  Map<String, dynamic> toGsheet() => {
        'Name': name,
        'e-mail': email,
        'Mobile': mobile,
        'Model Number': modelNumber,
        'Purchase Date': purchaseDate,
      };
}
