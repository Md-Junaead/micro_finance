import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:micro_finance/configs/viewmodels/reg_view_model.dart';
import 'package:micro_finance/configs/widgets/app_drawer.dart';
import 'package:micro_finance/configs/widgets/appbar.dart';
import 'package:micro_finance/screens/dashboard/help_screen.dart';
import 'package:micro_finance/screens/dashboard/packages_screen.dart';
import 'package:micro_finance/screens/dashboard/policies.dart';
import 'package:micro_finance/screens/dashboard/quick_loan_screen.dart';
import 'package:micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:micro_finance/screens/deposit/balance_save.dart';
import 'package:micro_finance/screens/deposit/balance_screen.dart';
import 'package:micro_finance/screens/policies/about_us.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserRegistrationViewModel>(context, listen: false);

    final List<Map<String, dynamic>> dashboardItems = [
      {"icon": Icons.add, "label": "Deposit", "screen": BalanceSaveScreen()},
      {
        "icon": Icons.paid_outlined,
        "label": "Package",
        "screen": const BalanceScreen()
      },
      {
        "icon": Icons.credit_card,
        "label": "Quick Loan",
        "screen": const QuickLoanScreen()
      },
      {
        "icon": Icons.people,
        "label": "Referrals",
        "screen": const ReferralsScreen()
      },
      {
        "icon": Icons.card_giftcard,
        "label": "Saving Plan",
        "screen": const PackagesScreen()
      },
      {
        "icon": Icons.contact_support,
        "label": "help",
        "screen": const HelpScreen()
      },
      {
        "icon": Icons.policy_outlined,
        "label": "Policies",
        "screen": Policies()
      },
      {"icon": Icons.info, "label": "About Us", "screen": AboutUs()},
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        // ✅ Task 2.2: Make screen scrollable
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // ✅ Task 1.1: Align items top-left
            children: [
              Wrap(
                // ✅ Replaces GridView for dynamic layout & no overlapping
                spacing: 5,
                runSpacing: 5, // ✅ Task 1.2: Minimize vertical gaps
                children: dashboardItems
                    .map((item) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 30) /
                              2, // 2 items per row
                          child: _buildGridItem(context, item),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20), // ✅ Spacing between grid and gif
              Center(
                child: Image.asset(
                  "assets/images/home/home_gif.gif", // ✅ Task 2.3: Add gif
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item["screen"] as Widget),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5), // ✅ spacing between rows
        decoration: BoxDecoration(
          color: const Color(0xFFFEF7FF),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item["icon"] as IconData,
                size: 50, color: const Color(0xFF06426D)),
            const SizedBox(height: 5),
            Text(
              item["label"] as String,
              style: const TextStyle(
                color: Color(0xFF06426D),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
