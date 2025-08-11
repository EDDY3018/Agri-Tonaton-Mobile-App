import 'package:agri_tonaton/features%20/modules/profile/view_model/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../profile/model/inbound_order.dart';
import 'widgets/inbound_order_card.dart';

class InboundOrdersPage extends StatefulWidget {
  const InboundOrdersPage({super.key});

  @override
  State<InboundOrdersPage> createState() => _InboundOrdersPageState();
}

class _InboundOrdersPageState extends State<InboundOrdersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = const Color(0xFF0B8A2A);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("In Bound Orders",
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tab,
              isScrollable: true,
              indicatorColor: brand,
              labelColor: brand,
              unselectedLabelColor: Colors.black54,
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: "New Orders"),
                Tab(text: "Pending orders"),
                Tab(text: "finished Orders"),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (_, vm, __) {
          final newOrders = vm.byStatus(InboundOrderStatus.newOrder);
          final pending = vm.byStatus(InboundOrderStatus.pending);
          final finished = vm.byStatus(InboundOrderStatus.finished);

          List<InboundOrder> _listFor(int index) =>
              index == 0 ? newOrders : index == 1 ? pending : finished;

          return TabBarView(
            controller: _tab,
            children: List.generate(3, (i) {
              final list = _listFor(i);
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: list.length,
                itemBuilder: (_, idx) => InboundOrderCard(order: list[idx]),
              );
            }),
          );
        },
      ),
    );
  }
}
