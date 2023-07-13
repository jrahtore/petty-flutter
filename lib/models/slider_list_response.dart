class SliderListResponse {
  String id;
  String name;
  String distance;
  String gender;
  String image;
  int superPettyStatus;
  List photos;
  List userCategories;
  List matchedCategories;
  String occupation;
  List subcategoryNames;
  String hobbies;
  String about;
  String age;
  List<dynamic> payment_type;

  SliderListResponse(
      {this.gender,
      this.name,
      this.image,
      this.occupation,
      this.hobbies,
      this.about,
      this.age,
      this.id,
      this.distance,
      this.superPettyStatus,
      this.matchedCategories,
      this.userCategories,
      this.photos,
      this.payment_type,
      this.subcategoryNames});

  factory SliderListResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SliderListResponse(
        gender: parsedJson["gender"],
        name: parsedJson["name"],
        distance: parsedJson["distance"],
        id: parsedJson["id"],
        image: parsedJson["profile_pic"],
        superPettyStatus: parsedJson["superpetty"],
        photos: parsedJson["photos"],
        userCategories: parsedJson["cat"],
        occupation: parsedJson["occupation"],
        hobbies: parsedJson["hobbies"] ?? '',
        about: parsedJson["biodata"] ?? '',
        age: parsedJson["age"] ?? '',
        subcategoryNames: parsedJson["subcategory_name"],
        payment_type: parsedJson["subscription_type"] ?? [],
        //todo
        matchedCategories: parsedJson["match_cat"].runtimeType == List
            ? parsedJson["match_cat"]
            : [3]);
  }
}
