part of 'utils.dart';

class BiometricUtil {
  static Future<bool> checkAccesoBiometrico() async {
    bool accesoBiometrico = false;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
    print('es android ${Platform.isAndroid}');

      if (Platform.isAndroid || Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          accesoBiometrico = true;
        }
      }

      print('accesoBiometrico');

      print(accesoBiometrico);

      return accesoBiometrico;
    } catch (e) {
      print(e.toString());
      print('cath');
    }
  }

  static Future<bool> biometrico() async {
    bool autenticar = false;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (Platform.isAndroid || Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }

        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          print('Touch ID');

          const androidString = const AndroidAuthMessages(
              cancelButton: "Cancelar",
              goToSettingsButton: "Ajustes",
              signInTitle: "Acceso con Huella",
              fingerprintHint: "Pon tu dedo en el sensor para acceder.",
              fingerprintNotRecognized: "Huella no Reconocida",
              fingerprintSuccess: "Huella Reconocida",
              goToSettingsDescription: "Configure su Huella");

          const iosStrings = const IOSAuthMessages(
              cancelButton: 'Cancelar',
              goToSettingsButton: 'Ajustes',
              goToSettingsDescription: 'Configure su Huella',
              lockOut: 'Vuelva a habilitar su Huella');

          autenticar = await auth.authenticateWithBiometrics(
              localizedReason: "Autentiquese para acceder",
              useErrorDialogs: false,
              stickyAuth: true,
              androidAuthStrings: androidString,
              iOSAuthStrings: iosStrings);
        }
      }

      if (!autenticar) {
        print(' eror No se autentico');
      }
      return autenticar;
    } on PlatformException catch (e) {
      print(e.toString());
      print('cath');
      return false;
    }
  }
}
