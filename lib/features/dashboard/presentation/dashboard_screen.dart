import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<SalesData> chartData = [
      SalesData('Oca', 35000),
      SalesData('Şub', 28000),
      SalesData('Mar', 34000),
      SalesData('Nis', 32000),
      SalesData('May', 40000),
      SalesData('Haz', 38000),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Genel Özet')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryCards(context),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aylık Satış Grafiği',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF265AA5),
                          ),
                    ),
                    const SizedBox(height: 16),
                    SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(
                        numberFormat: null, // format currency if needed
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<SalesData, String>>[
                        ColumnSeries<SalesData, String>(
                          dataSource: chartData,
                          xValueMapper: (SalesData data, _) => data.month,
                          yValueMapper: (SalesData data, _) => data.sales,
                          color: const Color(0xFF265AA5),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildInfoCard(context, 'Kasa', '₺ 125,000', Icons.wallet)),
        const SizedBox(width: 16),
        Expanded(child: _buildInfoCard(context, 'Alacak', '₺ 45,000', Icons.arrow_circle_down, color: Colors.green)),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String amount, IconData icon, {Color color = const Color(0xFF265AA5)}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;
  SalesData(this.month, this.sales);
}
