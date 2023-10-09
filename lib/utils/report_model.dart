class ReportModel{
    double? lat;
    double? long;
    String address;
    String? description;

    ReportModel({this.lat, this.long, required this.address, description});

     Map<String, dynamic> toJson() {
         final Map<String, dynamic> data = new Map<String, dynamic>();
         data['latitude'] = this.lat;
         data['longitude'] = this.long;
         data['address'] = this.address;
         data['description'] = this.description;
         return data;
       }

}
