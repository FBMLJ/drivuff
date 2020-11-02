class Fileitem {
  String id;
  String title;
  String filetype;
  bool done;
  DateTime date;
  //FileUploadInputElement fileUploadInputElement;
  bool aprovedbyadmin;
  String url;

  Fileitem({this.id, this.title, this.filetype, this.done, this.date, this.aprovedbyadmin,this.url});

  Fileitem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    filetype=json['filetype'];
    done = json['done'];
    date = DateTime.parse(json['date']);
    //fileUploadInputElement = json['fileUploadInputElement'];
    aprovedbyadmin = json['aprovedbyadmin'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['filetype'] = this.filetype;
    data['done'] = this.done;
    data['date'] = this.date.toString().substring(0, 10);
    data['aprovedbyadmin'] = this.aprovedbyadmin;
    data['url'] = this.url;
    return data;
  }
}
