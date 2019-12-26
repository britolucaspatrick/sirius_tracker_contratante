import 'dart:convert';

import 'dart:typed_data';

class Validator {
  static bool validateName(String text) {
    return text
        .contains(new RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"));
  }

  static bool validateNumber(String text) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(text);
  }

  static bool validateEmail(String text) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(text);
  }

  static bool validatePassword(String text) {
    return text.toString().length >= 6;
  }

  static String validateNumbers(String text){
    if (text == null || text.isEmpty)
      return "Informe telefone";
    else if (text.length < 10)
      return "DD0000-0000";
    return "";
  }

  static bool apenasLetrasRegExp(String text) =>
      text.contains(new RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]'));

  static bool apenasLetras(String text){
    List<String> aux = text.split('');
    int value;
    aux.forEach((f) => {
      value = AsciiCodec().encode(f)[0],
      print(value),
        if (value >= 97 && value <= 122 || //Letras minusculas
            value >= 65 && value <= 90 || //Letras maiusculas
            value == 128 || //Ç
            value == 130 || //é
            value == 131 || //â
            value == 133 || //à
            value == 135 || //ç
            value == 136 || //ê
            value == 144 || //É
            value == 147 || //ô
            value == 150 || //û
            value == 151 || //ù
            value == 198 || //ã
            value == 199 || //Ã
            value == 224 || //Ó
            value >= 160 && value <= 165 || //á, í, ó, ú, ñ, Ñ
            value >= 181 && value <= 183  ||//Á, Â, À
            value >= 210 && value <= 215  ||//Ê, i
            value >= 226 && value <= 229  ||//Ô, Ò, Õ
            value >= 233 && value <= 237  //u, y
        ){
          print(value),
          true
        }
        else false
    });

  }
}
