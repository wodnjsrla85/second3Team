// DatabaseHandler 클래스의 인스턴스를 오직 하나만 생성해서 앱 전체에서 공유 하도록 설계한 Singleton Pattern 입니다.
// Database와 같은 리소스를 공유하고자 할 때 사용


import 'package:path/path.dart';
import 'package:provider_must_eat_place_app/model/address.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  //
  static final DatabaseHandler _instance = DatabaseHandler._internal(); // Private constructor 내부 생성자
  factory DatabaseHandler() => _instance; // 호출할 때 마다 _instance를 반환
  DatabaseHandler._internal(); // 싱글턴 초기 작업

  static Database? _database;

  // DB 초기화 및 인스턴스 생성
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initializedDB();
    return _database!;
  }
  
  // DB 생성
  Future<Database> initializedDB()async{
    String path = join(await getDatabasesPath(), "address.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute(
          '''
            CREATE TABLE address(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              phone TEXT,
              estimate TEXT,
              lat REAL,
              lng REAL,
              image BLOB,
              actiondate TEXT
            )
          '''
        );
      }
    );
  }

  // 입력
  Future<void> insertAddress(Address address)async{
    final db = await database;
    await db.rawInsert(
      '''
        INSERT INTO address(name, phone, estimate, lat, lng, image, actiondate)
        VALUES (?,?,?,?,?,?,datetime('now', 'localtime'))
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.image
      ]
    );
  }

  // 주소 전체 조회
  Future<List<Address>> queryAddress()async{
    final db = await database;
    final result = await db.rawQuery('SELECT * FROM address');
    return result.map((data) => Address.fromMap(data)).toList();
  }

  // 주소 삭제
  Future<void> deleteAddress(int id)async{
    final db = await database;
    await db.rawDelete('DELETE FROM address WHERE id = ?', [id]);
  }

  // 이미지 제외 수정
  Future<void> updateAddress(Address address)async{
    final db = await database;
    await db.rawUpdate(
      '''
        UPDATE address
        set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, actiondate=datetime('now', 'localtime')
        WHERE id = ?
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.id
      ]
    );
  }

  // 이미지 포함 수정
  Future<void> updateAddressAll(Address address)async{
    final db = await database;
    await db.rawUpdate(
      '''
        UPDATE address
        set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, image = ?, actiondate=datetime('now', 'localtime')
        WHERE id = ?
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.image,
        address.id
      ]
    );
  }

}