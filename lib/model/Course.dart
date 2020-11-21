class Course{
  String name;
  
  Course(this.name);

  Map<String, dynamic> toMap(){

    return  {
      "nome" : this.name,
      "iscourse": true
    };
  }
  Map<String, dynamic> toMap1(String dono){

    return {
      "nome" : "Provas Antigas",
      "dono": dono
    };
  }Map<String, dynamic> toMap2(String dono){

    return {
      "nome" : "Provas Antigas 2",
      "dono": dono
    };
  }Map<String, dynamic> toMap3(String dono){

    return{
      "nome" : "Provas Antigas 3",
      "dono": dono
    };
  }


}