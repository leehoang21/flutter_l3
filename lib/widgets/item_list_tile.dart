import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/instruments_and_tools_screen.dart';
class ItemListTile extends StatelessWidget{
  final String title;
  final int index;
  final VoidCallback onClickItem;
  const ItemListTile({super.key, required this.title, required this.index, required this.onClickItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClickItem();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          leading: const Icon(Icons.square,color: Colors.white,size: 20,),
          title: Text(title,style: const TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}