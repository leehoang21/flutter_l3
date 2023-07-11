import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/widgets/item_list_tile.dart';
import '../controller/auth_controller.dart';

class CustomDrawer extends StatefulWidget{
  final VoidCallback logOut;
  final void Function(String) changePage;
  const CustomDrawer({super.key, required this.logOut, required this.changePage});
  @override
  State<StatefulWidget> createState() => DrawerState();
}
class DrawerState extends State<CustomDrawer>{
  DrawerState();
  var showCCDC = false.obs;
  var showShopping = false.obs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff7377c5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Color(0xff5f62a1)
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'AMMIS',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade200,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_sharp,
                        color: Colors.grey.shade200,
                        size: 60,
                      ),
                      GetBuilder<AuthController>(
                        builder: (controller) => Text(
                          controller.user.displayName ?? "",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade200,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(

            leading: const Icon(Icons.grid_view_rounded,color: Colors.white,),
            title: const Text('Trang chủ',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Xử lý khi người dùng chọn mục trong drawer
              widget.changePage("Trang chủ");
            },
          ),
          ExpansionTile(
            onExpansionChanged: (isExpand){
              showShopping.value = isExpand;
            },
            title: const Text('Quản lý mua sắm',style: TextStyle(color: Colors.white),),
            leading: const Icon(Icons.text_snippet,color: Colors.white,),
            trailing: Obx(() => showShopping.value ? const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.white,): const Icon(Icons.arrow_right_outlined,size: 30,color: Colors.white,),),
            children: [
              Container(
                color: const Color(0xff5f62a1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    leading: const Icon(Icons.square,color: Colors.white,size: 20,),
                    title: const Text('Mua sắm tài sản',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      // Xử lý khi người dùng chọn mục trong drawer
                    },
                  ),
                ),
              ),
            ],
          ),
          ExpansionTile(
            onExpansionChanged: (isExpand){
              showCCDC.value = isExpand;
            },
            leading: const Icon(Icons.credit_card_rounded,color: Colors.white,),
            title: const Text('Quản lý CCDC',style: TextStyle(color: Colors.white),),
            trailing: Obx(() => showCCDC.value ? const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.white,): const Icon(Icons.arrow_right_outlined,size: 30,color: Colors.white,),),
            children: [
              Container(
                color: const Color(0xff5f62a1),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemListTile(
                      title: listCCDC()[index],
                      index: index,
                      onClickItem: () {
                        onItemClick(listCCDC()[index]);
                      },
                    );
                  },
                  itemCount: listCCDC().length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(top: 0),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text('Đăng xuất',style: TextStyle(color: Colors.white),),
            leading: const Icon(Icons.exit_to_app,color: Colors.white,),
            onTap: widget.logOut,
          )
        ],
      ),
    );
  }
  List<String> listCCDC(){
    return [
      'Danh sách CCDC',
      'Cấp phát CCDC',
      'Điều chuyển CCDC',
      'Kiểm kê CCDC',
      'Thanh lý CCDC',
      'CCDC chuyển đi'
    ];
  }
  void onItemClick(String title){
    widget.changePage(title);
  }
}