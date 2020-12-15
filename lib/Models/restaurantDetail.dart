class RestaurantDetail {
  String name;
  String location;
  String img;
  num rate;
  String sort;
  String rId;

  

  RestaurantDetail(
      {this.name, this.location, this.img, this.rate, this.rId, this.sort});

  RestaurantDetail.fromMap(Map snapshot, String id)
      : rId = id ?? '',
        name = snapshot['name'] ?? '',
        location = snapshot['location'] ?? '',
        img = snapshot['img'] ?? '',
        sort = snapshot['sort'],
        rate = snapshot['rate'] ?? '' ;
        

  toJson() {
    return {
      "rId": rId,
      "name": name,
      "location": location,
      "img": img,
      "sort":sort,
      "rate": rate,
    };
  }
}
