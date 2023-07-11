import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/ccdc_controller.dart';
import 'package:timesheet/data/model/body/model_ccdc/item_content.dart';
import 'package:timesheet/widgets/item_ccdc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InstrumentAndTool extends StatefulWidget {
  const InstrumentAndTool({super.key});

  @override
  State<StatefulWidget> createState() => _InstrumentAndToolState();
}

class _InstrumentAndToolState extends State<InstrumentAndTool> with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  static const _pageSize = 10;
  final PagingController<int, ItemContent> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    Get.find<CCDCController>().getAllocationVouchers(null);
    _pagingController.addPageRequestListener((pageKey) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: TabBar(
                    labelColor: Colors.black,
                    isScrollable: true,
                    labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    indicatorColor: const Color(0xff7377c5),
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Colors.grey.shade400,
                    controller: TabController(length: 4, vsync: this),
                    onTap: (index){onTabChange(index);},
                    tabs: const [
                      Tab(
                        text: "Tất cả",
                      ),
                      Tab(
                        text: "Tạo mới",
                      ),
                      Tab(
                        text: "Đã cấp phát",
                      ),
                      Tab(
                        text: "Trả về",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GetBuilder<CCDCController>(
                    builder: (controller) => Opacity(
                      opacity: controller.loading? 0.2 : 1,
                      child: (controller.ccdc.data?.content != null && controller.ccdc.data!.content!.isNotEmpty)?
                      SingleChildScrollView(
                        controller: _controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                            margin: const EdgeInsets.all(16),
                            child: ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount: controller.ccdc.data?.content?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return controller.ccdc.data?.content?[index] != null ? ItemCCDC(content: controller.ccdc.data!.content![index] ,index: index,) : const Text('Lỗi');
                                })
                        ),
                      ) : const Center(child: Text('Không có bản ghi nào')),
                    ),
                  )
                ),
              ],
            ),
            Center(
            child: GetBuilder<CCDCController>(
              builder: (controller) => Visibility(
                  visible: controller.loading,
                  child: const CircularProgressIndicator(color: Colors.deepPurpleAccent,)
              ),
            )
          ),
        ],
      )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7377c5),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  void getAllocationVouchers(){
    Get.find<CCDCController>().getAllocationVouchers(null);
  }
  void onTabChange(int index){
    if(index > 0) {
      Get.find<CCDCController>().getAllocationVouchers(index - 1);
    }
    else {
      Get.find<CCDCController>().getAllocationVouchers(null);
    }
  }
}
