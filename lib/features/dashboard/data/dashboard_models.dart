import 'package:json_annotation/json_annotation.dart';

part 'dashboard_models.g.dart';

@JsonSerializable()
class Account {
  final int id;
  @JsonKey(name: 'company_id')
  final int? companyId;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(name: 'number', defaultValue: '')
  final String iban; // API'de "number" olarak geliyor
  @JsonKey(name: 'currency_code', defaultValue: 'TRY')
  final String currency; // API'de "currency_code" olarak geliyor
  @JsonKey(name: 'current_balance', defaultValue: 0.0)
  final double balance; // API'de "current_balance" olarak geliyor
  @JsonKey(name: 'current_balance_formatted', defaultValue: '')
  final String balanceFormatted;
  @JsonKey(name: 'opening_balance', defaultValue: 0.0)
  final double? openingBalance;
  @JsonKey(name: 'bank_name')
  final String? bankName;
  @JsonKey(name: 'bank_phone')
  final String? bankPhone;
  @JsonKey(name: 'bank_address')
  final String? bankAddress;
  @JsonKey(defaultValue: true)
  final bool enabled;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  // UI için accountNo yok, iban'ın son 4 hanesini kullanabiliriz
  String get accountNo => iban.length > 4 ? iban.substring(iban.length - 4) : iban;

  Account({
    required this.id,
    this.companyId,
    required this.name,
    required this.iban,
    required this.currency,
    required this.balance,
    this.balanceFormatted = '',
    this.openingBalance,
    this.bankName,
    this.bankPhone,
    this.bankAddress,
    this.enabled = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@JsonSerializable()
class Transaction {
  final int id;
  final String title; // Örn: "Market Alışverişi"
  final String? description; // Örn: "Migros A.Ş."
  final double amount; // -320.50 veya +1000.00
  @JsonKey(name: 'created_at')
  final String date; // ISO8601 string
  final String type; // income, expense

  Transaction({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}

@JsonSerializable()
class AccountResponse {
  @JsonKey(defaultValue: true)
  final bool success;
  @JsonKey(defaultValue: [])
  final List<Account> data;

  AccountResponse({required this.success, required this.data});

  factory AccountResponse.fromJson(Map<String, dynamic> json) => _$AccountResponseFromJson(json);
}

@JsonSerializable()
class TransactionResponse {
  @JsonKey(defaultValue: true)
  final bool success;
  @JsonKey(defaultValue: [])
  final List<Transaction> data;

  TransactionResponse({required this.success, required this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);
}
