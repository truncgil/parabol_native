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
  @JsonKey(name: 'company_id')
  final int? companyId;
  @JsonKey(name: 'account_id')
  final int? accountId;
  @JsonKey(name: 'contact_id')
  final int? contactId;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(defaultValue: '')
  final String? description;
  @JsonKey(defaultValue: 0.0)
  final double amount;
  @JsonKey(name: 'amount_formatted', defaultValue: '')
  final String? amountFormatted;
  @JsonKey(name: 'currency_code', defaultValue: 'TRY')
  final String? currencyCode;
  @JsonKey(name: 'currency_rate', defaultValue: 1.0)
  final double? currencyRate;
  @JsonKey(name: 'paid_at', defaultValue: '')
  final String date; // API'de "paid_at" olarak geliyor
  @JsonKey(defaultValue: 'expense')
  final String type; // income, expense
  @JsonKey(defaultValue: '')
  final String? reference;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'contact_name', defaultValue: '')
  final String? contactName;
  @JsonKey(name: 'category_name', defaultValue: '')
  final String? categoryName;
  @JsonKey(name: 'account_name', defaultValue: '')
  final String? accountName;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  // UI için title - contactName veya categoryName kullan
  String get title => contactName?.isNotEmpty == true 
      ? contactName! 
      : (categoryName?.isNotEmpty == true ? categoryName! : 'İşlem');

  Transaction({
    required this.id,
    this.companyId,
    this.accountId,
    this.contactId,
    this.categoryId,
    this.description,
    required this.amount,
    this.amountFormatted,
    this.currencyCode,
    this.currencyRate,
    required this.date,
    required this.type,
    this.reference,
    this.paymentMethod,
    this.contactName,
    this.categoryName,
    this.accountName,
    this.createdAt,
    this.updatedAt,
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
