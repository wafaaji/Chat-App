import 'package:get_storage/get_storage.dart';

class SecureStorage{

  final storage = GetStorage();

  Future<void> save(String key, dynamic value) async{
    await storage.write(key, value);
  }

  Future<String?> read(String key) async{
    return storage.read(key);
  }

  Future<void> delete(String key) async{
    await storage.remove(key);
  }

}