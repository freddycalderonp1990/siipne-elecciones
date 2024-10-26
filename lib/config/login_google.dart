class LoginGoogle {
  static String getDataUser() {
    String jsonResponse = '''{
  "usuario": {
    "codeError": 0,
    "msj": "existe",
    "datos": [
      {
        "idGenUsuario": 55948,
        "idGenPersona": 724115,
        "nombreUsuario": "testGooglePoliciaEcuador",
          "apenom": "TEST. GOOGLE - POLICÍA ECUADOR",
        "documento": "000000000",
        "sexoPerson": "HOMBRE",
        "actualizarApp": false,
        "foto": null,
        "session": true,
        "motivo": "Puede iniciar sesión"
      }
    ]
  }
}''';
    return jsonResponse;
  }
}
