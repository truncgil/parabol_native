// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  id: (json['id'] as num).toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  name: json['name'] as String? ?? '',
  iban: json['number'] as String? ?? '',
  currency: json['currency_code'] as String? ?? 'TRY',
  balance: (json['current_balance'] as num?)?.toDouble() ?? 0.0,
  balanceFormatted: json['current_balance_formatted'] as String? ?? '',
  openingBalance: (json['opening_balance'] as num?)?.toDouble() ?? 0.0,
  bankName: json['bank_name'] as String?,
  bankPhone: json['bank_phone'] as String?,
  bankAddress: json['bank_address'] as String?,
  enabled: json['enabled'] as bool? ?? true,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'name': instance.name,
  'number': instance.iban,
  'currency_code': instance.currency,
  'current_balance': instance.balance,
  'current_balance_formatted': instance.balanceFormatted,
  'opening_balance': instance.openingBalance,
  'bank_name': instance.bankName,
  'bank_phone': instance.bankPhone,
  'bank_address': instance.bankAddress,
  'enabled': instance.enabled,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  amount: (json['amount'] as num).toDouble(),
  date: json['created_at'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'created_at': instance.date,
      'type': instance.type,
    };

AccountResponse _$AccountResponseFromJson(Map<String, dynamic> json) =>
    AccountResponse(
      success: json['success'] as bool? ?? true,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AccountResponseToJson(AccountResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      success: json['success'] as bool? ?? true,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionResponseToJson(
  TransactionResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};
