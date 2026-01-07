import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dashboard_controller.dart';
import '../data/dashboard_models.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildHeader(context),
              ),
              const SizedBox(height: 24),
              _buildAccountsCarousel(context, ref),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ActionButtons(),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSectionTitle(context, 'Son Hareketler'),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildTransactionList(ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Günaydın,',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Trunçgil Teknoloji',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.person, color: Color(0xFF265AA5)),
        ),
      ],
    );
  }

  Widget _buildAccountsCarousel(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountListProvider);

    return accountsAsync.when(
      data: (accounts) {
        if (accounts.isEmpty) {
          return Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF265AA5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(child: Text('Hesap Bulunamadı', style: TextStyle(color: Colors.white))),
          );
        }

        return SizedBox(
          height: 220, // Kart yüksekliği
          child: PageView.builder(
            // PadEnds false yaparak ilk kartın solunda boşluk olmamasını sağlayabiliriz ama 
            // ortalı durması daha şık. viewportFraction'ı biraz küçültelim.
            controller: PageController(viewportFraction: 0.85),
            padEnds: false, // Kartlar soldan başlasın
            itemCount: accounts.length,
            onPageChanged: (index) {
              ref.read(selectedAccountIndexProvider.notifier).state = index;
            },
            itemBuilder: (context, index) {
              // İlk eleman için sol boşluk, diğerleri için sadece sağ boşluk
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 20 : 0, 
                  right: 16
                ),
                child: _AccountCard(account: accounts[index]),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox(height: 220, child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => SizedBox(height: 220, child: Center(child: Text('Hata: $err'))),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Tümünü Gör',
            style: TextStyle(color: Color(0xFF265AA5)),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionListProvider);

    return transactionsAsync.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return const Center(child: Text('Bu hesaba ait işlem yok.'));
        }
        // Son 20 hareket ile sınırla
        final displayList = transactions.take(20).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayList.length,
          itemBuilder: (context, index) {
            return _TransactionItem(transaction: displayList[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Hata: $err')),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  const _AccountCard({required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF265AA5), Color(0xFF1A4F9C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF265AA5).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${account.currency == 'TRY' ? '₺' : account.currency} ${account.balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SvgPicture.string(
                '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 5000 8830">
                  <path fill="#FFFFFF" fill-rule="evenodd" d="M3647.41 2495.57c0,-552.07 -33.33,-1108.42 388.96,-1530.68 392.37,-392.34 822.51,-412.99 1338.75,-412.99 830.19,0 1391.76,623.43 1391.76,1463.77 0,584.69 37.09,1113.23 -413.25,1554.4 -425.81,417.17 -1292.89,485.95 -1832.69,283.59 -578.83,-217.02 -873.53,-732.97 -873.53,-1358.08zm1279.85 -2495.57l588.06 0c324.26,24.15 638.86,88.06 918.71,188.9 534.95,192.77 906.62,554.22 1156.9,1050.69 313.75,622.41 309.62,1416.03 0,2032.03 -133.74,266.14 -278.88,474.79 -495.15,656.66 -901.75,758.29 -2490.06,730.11 -3448.37,223.03l0 2951.47 1031.8 0c55.31,0 72,16.69 72,72 0,928.93 66.17,820.43 -239.52,816.3l-936.27 -0.44c-51.3,-220.15 -24.01,-620.31 -24.01,-863.85l-959.86 0 0 -4487.23c-600.96,317.96 -1623.3,282.39 -2104.96,-126.67 -420.73,-357.29 -486.6,-723.66 -486.6,-1241.11 0,-229.99 145.5,-560.68 282.21,-725.62 437.9,-528.23 849.3,-545.73 1509.88,-546.15l31.62 0c607.6,0 1109.47,346.42 1319.79,743.88 61.52,-41.23 198.99,-189.94 369.18,-302.72 390.91,-258.99 895.94,-402.28 1414.58,-441.16zm-4255.36 1655.72c0,-466.62 -65.58,-763.73 293.47,-1098.28 414.64,-386.34 1650.2,-321.66 1650.2,666.37l0 431.92c0,431.59 -361.69,815.85 -791.87,815.85l-359.94 0c-420.85,0 -791.87,-398.13 -791.87,-815.85z"/>
                </svg>''',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CopyableInfo(label: 'IBAN', value: account.iban),
              _CopyableInfo(label: 'HESAP NO', value: account.accountNo),
            ],
          ),
        ],
      ),
    );
  }
}

class _CopyableInfo extends StatelessWidget {
  final String label;
  final String value;

  const _CopyableInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label kopyalandı: $value')),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.copy, size: 10, color: Colors.white.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value.length > 15 ? '${value.substring(0, 8)}...' : value, // Uzunsa kısalt
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(Icons.arrow_upward, 'Gönder'),
        _buildActionButton(Icons.arrow_downward, 'İste'),
        _buildActionButton(Icons.add, 'Yükle'),
        _buildActionButton(Icons.more_horiz, 'Diğer'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF265AA5), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense' || transaction.amount < 0;
    final color = isExpense ? Colors.red : Colors.green;
    final prefix = isExpense ? '' : '+'; // Eksi zaten sayıdan gelir

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF265AA5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isExpense ? Icons.shopping_bag_outlined : Icons.account_balance_wallet_outlined,
              color: const Color(0xFF265AA5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (transaction.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    transaction.description!,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$prefix${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.date.split(' ').first, // Sadece tarih
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
