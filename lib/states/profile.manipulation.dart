import 'package:crypt/crypt.dart';
import 'package:flower_ui/entities/account.dart';
import 'package:flower_ui/entities/store.dart';
import 'package:flower_ui/states/web.api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileManipulation {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static Account account;
  static Store store;

  static Future<Account> _getAccount(Account account) async {
    Account accountBD;

    await WebApiServices.fetchAccounts().then((response) {
      var accountData = accountFromJson(response.data);
      accountBD = accountData.firstWhere(
          (element) =>
              element.login == account.login && element.role == "store",
          orElse: () => null);
    });
    if (accountBD == null) return null;

    final crypto = Crypt.sha256(account.passwordHash, salt: accountBD.salt);

    if (accountBD.passwordHash == crypto.hash) {
      return accountBD;
    } else
      return null;
  }

  static Future<Store> getStoreConfig(Account account) async {
    Account accountBD = await _getAccount(account);

    if (accountBD == null) return null;

    Store store;
    await WebApiServices.fetchStores().then((response) {
      var storeData = storeFromJson(response.data);
      store = storeData.firstWhere(
          (element) => element.accountId == accountBD.id,
          orElse: () => null);
    });

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", accountBD.id);
    prefs.setInt("StoreId", store.id);

    return store;
  }

  static Future<bool> addStoreConfig(Account account, Store store) async {
    final crypto = Crypt.sha256(account.passwordHash);
    account.passwordHash = crypto.hash;
    account.salt = crypto.salt;
    account.role = "store";

    List<Account> _accounts = [];
    await WebApiServices.fetchAccounts().then((response) {
      var accountsData = accountFromJson(response.data);
      _accounts = accountsData.toList();
    });

    for (var item in _accounts) {
      if (item.login == account.login) return false;
    }

    await WebApiServices.postAccount(account);
    await WebApiServices.fetchAccounts().then((response) {
      var accountsData = accountFromJson(response.data);
      _accounts = accountsData.toList();
    });

    store.accountId = _accounts.toList().last.id;
    await WebApiServices.postStore(store);
    return true;
  }

  static searchProfile() async {
    final SharedPreferences prefs = await _prefs;

    await WebApiServices.fetchAccounts().then((response) {
      var accountData = accountFromJson(response.data);
      account = accountData
          .firstWhere((element) => element.id == prefs.getInt('AccountId'));
      print(ProfileManipulation.account.id);
    });

    await WebApiServices.fetchStores().then((response) {
      var storeData = storeFromJson(response.data);
      store = storeData
          .firstWhere((element) => element.id == prefs.getInt('StoreId'));
    });
  }
}
