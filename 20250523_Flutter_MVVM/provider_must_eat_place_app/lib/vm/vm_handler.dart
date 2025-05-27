import 'package:flutter/widgets.dart';
import 'package:provider_must_eat_place_app/model/address.dart';
import 'package:provider_must_eat_place_app/vm/database_handler.dart';

class VMModel with ChangeNotifier {
  final DatabaseHandler _dbHandler = DatabaseHandler();
  List<Address> _address = [];
  List<Address> get address => _address;

  Future<void> loadAddress() async {
    _address = await _dbHandler.queryAddress();
    notifyListeners();
  }

  Future<void> insertAddress(Address address) async {
    await _dbHandler.insertAddress(address);
    await loadAddress();
  }

  Future<void> updateAddress(Address address) async {
    await _dbHandler.updateAddress(address);
    await loadAddress();
  }

  Future<void> updateAddressAll(Address address) async {
    await _dbHandler.updateAddressAll(address);
    await loadAddress();
  }

  Future<void> deleteAddress(int id) async {
    await _dbHandler.deleteAddress(id);
    await loadAddress();
  }
}
