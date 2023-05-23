class InvoiceOrderAddress {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  List<String>? address1;
  String? country;
  String? countryName;
  String? state;
  String? city;
  String? postcode;
  String? phone;
  String? createdAt;
  String? updatedAt;

  InvoiceOrderAddress(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.address1,
      this.country,
      this.countryName,
      this.state,
      this.city,
      this.postcode,
      this.phone,
      this.createdAt,
      this.updatedAt});

  InvoiceOrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'].cast<String>();
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
