class Data{
  String cityName;
  String  cityUrl;

  Data({this.cityName,this.cityUrl});

  Data.fromJson(Map<String, dynamic> json) {

    cityName = json['cityName'];
    cityUrl = json['cityUrl'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['cityUrl'] = this.cityUrl;



  }




}
