class Address {
  late final String street;
  late final int houseNumber;
  late final String postalCode;
  String city = "Bamberg";
  String country = "Germany";

  Address(this.street, this.houseNumber, this.city, this.postalCode, this.country);
}