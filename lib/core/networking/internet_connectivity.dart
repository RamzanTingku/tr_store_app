import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class InternetConnectivity{

  static final InternetConnectivity _instance = InternetConnectivity._internal();
  factory InternetConnectivity() {
    return _instance;
  }
  InternetConnectivity._internal();

  late StreamSubscription _connectivityStreamSubscription;
  final _connectivityStreamController = BehaviorSubject<bool>();
  Sink<bool> get _connectivitySink => _connectivityStreamController.sink;
  Stream<bool> get connectivityStream => _connectivityStreamController.stream;

  Future<bool> checkInternet() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return (result == ConnectivityResult.mobile || result ==  ConnectivityResult.wifi) && await _checkConnection();
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> subscribeConnectivityLister() async{
    _connectivitySink.add(await checkInternet());
    _connectivityStreamSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      _connectivitySink.add(await checkInternet());
    });
  }

  void closeSubscriptions() async {
    await _connectivityStreamSubscription.cancel();
    await _connectivityStreamController.drain();
    _connectivityStreamController.close();
  }
}