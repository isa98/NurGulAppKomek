import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app.dart';
import 'widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      builder: (oc) {
        final bool isLastPage = oc.olState.lastPage.value;
        return Scaffold(
          appBar: AppBar(
            leading: const CircleButton(),
            centerTitle: true,
            title: Text('order_order_title'.tr.toUpperCase()),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: oc.obx(
                  (state) => state != null
                      ? RefreshIndicator(
                          onRefresh: oc.refreshList,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: ListView.separated(
                              controller: oc.scroll,
                              itemCount: state.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.length) {
                                  final OrderModel item = state[index];
                                  return OrderItemWidget(order: item);
                                } else if (index == state.length && !isLastPage) {
                                  return const CustomLoader();
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                              separatorBuilder: (_, int index) => const Divider(
                                height: 0.5,
                                thickness: 1.5,
                              ),
                            ),
                          ),
                        )
                      : RetryWidget(onRetry: oc.refreshList),
                  onLoading: const CustomLoader(),
                  onEmpty: const NotFoundWidget(),
                  onError: (error) => RetryWidget(onRetry: oc.refreshList),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
