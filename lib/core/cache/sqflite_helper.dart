import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SavedCardModel {
  final int? id;
  final String cardHolderName;
  final String last4;
  final String brand;
  final int expiryMonth;
  final int expiryYear;
  final String paymentMethodId;

  SavedCardModel({
    this.id,
    required this.cardHolderName,
    required this.last4,
    required this.brand,
    required this.expiryMonth,
    required this.expiryYear,
    required this.paymentMethodId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'last4': last4,
      'brand': brand,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'paymentMethodId': paymentMethodId,
    };
  }

  factory SavedCardModel.fromMap(Map<String, dynamic> map) {
    return SavedCardModel(
      id: map['id'],
      cardHolderName: map['cardHolderName'],
      last4: map['last4'],
      brand: map['brand'],
      expiryMonth: map['expiryMonth'],
      expiryYear: map['expiryYear'],
      paymentMethodId: map['paymentMethodId'],
    );
  }
}

class SqfliteHelper {
  static final SqfliteHelper instance = SqfliteHelper._();

  static Database? _database;

  SqfliteHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'control_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createCardsTable(db);
  }

  Future<void> _createCardsTable(Database db) async {
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardHolderName TEXT NOT NULL,
        last4 TEXT NOT NULL,
        brand TEXT NOT NULL,
        expiryMonth INTEGER NOT NULL,
        expiryYear INTEGER NOT NULL,
        paymentMethodId TEXT NOT NULL
      )
    ''');
  }

  // --- Card Methods ---
  Future<int> insertCard(SavedCardModel card) async {
    final db = await database;
    return await db.insert('cards', card.toMap(), 
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SavedCardModel>> getSavedCards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cards');
    return List.generate(maps.length, (i) => SavedCardModel.fromMap(maps[i]));
  }

  Future<int> deleteCard(int id) async {
    final db = await database;
    return await db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
