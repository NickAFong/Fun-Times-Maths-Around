class TextToData{
  Map<String, String> textToImageMap = {};

  TextToData(){
    add();
  }

  static final TextToData _internal = TextToData._privateConstructor();

  TextToData._privateConstructor();

  static TextToData instance(){
    
    return _internal;
  }

  List<String>? convert(String value){
    add();
    List<String> results = [];
    if(value.length > 1){
       for(int i= 0; i< value.length; i++){
         results.add(textToImageMap[value[i]] ??""); 
      }
    }else{
      results.add(textToImageMap[value[0]] ??"");
    }
   
    return results;
  }

  void add(){
    const assets = "assets/";
    for(int i=0; i < 10; i++){
      textToImageMap[i.toString()] = "$assets$i.png";
      
    }
    textToImageMap["+"] = "$assets/add.png";
    textToImageMap["-"] = "$assets/subtract.png";
    textToImageMap["*"] = "$assets/multiply.png";
    textToImageMap["/"] = "$assets/divide.png";
    textToImageMap["="] = "$assets/equals.png";
  }






}