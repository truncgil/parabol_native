import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';
import '../data/dashboard_models.dart';

// Hesap Listesi
final accountListProvider = FutureProvider<List<Account>>((ref) async {
  final repository = ref.read(dashboardRepositoryProvider);
  return await repository.getAccounts();
});

// Seçili Hesap Index'i (UI'da swipe ettikçe değişecek)
final selectedAccountIndexProvider = StateProvider<int>((ref) => 0);

// Seçili Hesabı Veren Computed Provider
final selectedAccountProvider = Provider<AsyncValue<Account?>>((ref) {
  final accounts = ref.watch(accountListProvider);
  final index = ref.watch(selectedAccountIndexProvider);
  
  return accounts.whenData((data) {
    if (data.isEmpty) return null;
    if (index >= data.length) return data.last;
    return data[index];
  });
});

// Transaction sayfalama parametreleri
final transactionPageProvider = StateProvider<int>((ref) => 1);
final transactionLimitProvider = StateProvider<int>((ref) => 15);

// İşlem Listesi (Seçili hesaba göre otomatik yenilenir)
final transactionListProvider = FutureProvider<List<Transaction>>((ref) async {
  final selectedAccountAsync = ref.watch(selectedAccountProvider);
  
  // Hesap henüz yüklenmediyse veya yoksa boş dön
  if (selectedAccountAsync.value == null) return [];

  final accountId = selectedAccountAsync.value!.id;
  final page = ref.watch(transactionPageProvider);
  final limit = ref.watch(transactionLimitProvider);
  final repository = ref.read(dashboardRepositoryProvider);
  
  return await repository.getTransactions(
    accountId,
    page: page,
    limit: limit,
    sort: 'paid_at',
  );
});
