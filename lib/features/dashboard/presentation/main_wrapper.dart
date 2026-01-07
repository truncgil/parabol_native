import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF265AA5),
          shape: const CircleBorder(),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding azaltıldı (16 -> 12)
            // Dosya yerine doğrudan String olarak SVG'yi veriyoruz
            child: SvgPicture.string(
              '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 5000 8830"> <!-- ViewBox daraltıldı -->
                <path fill="#FFFFFF" fill-rule="evenodd" d="M3647.41 2495.57c0,-552.07 -33.33,-1108.42 388.96,-1530.68 392.37,-392.34 822.51,-412.99 1338.75,-412.99 830.19,0 1391.76,623.43 1391.76,1463.77 0,584.69 37.09,1113.23 -413.25,1554.4 -425.81,417.17 -1292.89,485.95 -1832.69,283.59 -578.83,-217.02 -873.53,-732.97 -873.53,-1358.08zm1279.85 -2495.57l588.06 0c324.26,24.15 638.86,88.06 918.71,188.9 534.95,192.77 906.62,554.22 1156.9,1050.69 313.75,622.41 309.62,1416.03 0,2032.03 -133.74,266.14 -278.88,474.79 -495.15,656.66 -901.75,758.29 -2490.06,730.11 -3448.37,223.03l0 2951.47 1031.8 0c55.31,0 72,16.69 72,72 0,928.93 66.17,820.43 -239.52,816.3l-936.27 -0.44c-51.3,-220.15 -24.01,-620.31 -24.01,-863.85l-959.86 0 0 -4487.23c-600.96,317.96 -1623.3,282.39 -2104.96,-126.67 -420.73,-357.29 -486.6,-723.66 -486.6,-1241.11 0,-229.99 145.5,-560.68 282.21,-725.62 437.9,-528.23 849.3,-545.73 1509.88,-546.15l31.62 0c607.6,0 1109.47,346.42 1319.79,743.88 61.52,-41.23 198.99,-189.94 369.18,-302.72 390.91,-258.99 895.94,-402.28 1414.58,-441.16zm-4255.36 1655.72c0,-466.62 -65.58,-763.73 293.47,-1098.28 414.64,-386.34 1650.2,-321.66 1650.2,666.37l0 431.92c0,431.59 -361.69,815.85 -791.87,815.85l-359.94 0c-420.85,0 -791.87,-398.13 -791.87,-815.85z"/>
              </svg>''',
              // Boyutlar kaldırıldı, parent'a uyması sağlandı
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        height: 70,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 0, Icons.speed_outlined, 'Özet'),
            _buildNavItem(context, 1, Icons.inventory_2_outlined, 'Ürün'),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(context, 2, Icons.account_balance_outlined, 'Banka'),
            _buildNavItem(context, 3, Icons.menu, 'Menü'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = navigationShell.currentIndex == index;
    final color = isSelected ? const Color(0xFF265AA5) : Colors.grey;

    return InkWell(
      onTap: () => navigationShell.goBranch(index),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
