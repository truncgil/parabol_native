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
  companyId: (json['company_id'] as num?)?.toInt(),
  accountId: (json['account_id'] as num?)?.toInt(),
  contactId: (json['contact_id'] as num?)?.toInt(),
  categoryId: (json['category_id'] as num?)?.toInt(),
  description: json['description'] as String? ?? '',
  amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
  amountFormatted: json['amount_formatted'] as String? ?? '',
  currencyCode: json['currency_code'] as String? ?? 'TRY',
  currencyRate: (json['currency_rate'] as num?)?.toDouble() ?? 1.0,
  date: json['paid_at'] as String? ?? '',
  type: json['type'] as String? ?? 'expense',
  reference: json['reference'] as String? ?? '',
  paymentMethod: json['payment_method'] as String?,
  contactName: json['contact_name'] as String? ?? '',
  categoryName: json['category_name'] as String? ?? '',
  accountName: json['account_name'] as String? ?? '',
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'account_id': instance.accountId,
      'contact_id': instance.contactId,
      'category_id': instance.categoryId,
      'description': instance.description,
      'amount': instance.amount,
      'amount_formatted': instance.amountFormatted,
      'currency_code': instance.currencyCode,
      'currency_rate': instance.currencyRate,
      'paid_at': instance.date,
      'type': instance.type,
      'reference': instance.reference,
      'payment_method': instance.paymentMethod,
      'contact_name': instance.contactName,
      'category_name': instance.categoryName,
      'account_name': instance.accountName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
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
