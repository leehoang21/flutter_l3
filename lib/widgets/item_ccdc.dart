import 'package:flutter/material.dart';
import '../data/model/body/model_ccdc/item_content.dart';
import 'package:intl/intl.dart';

class ItemCCDC extends StatelessWidget {
  final ItemContent content;
  final int index;

  const ItemCCDC({super.key, required this.content, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            "${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
        ),
        Expanded(
          child: Card(
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      color: color(content.allocationStatusIndex),
                      child:  Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text( status(content.allocationStatusIndex),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Người cấp phát : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: content.handoverPersonName,
                              style: const TextStyle(color: Colors.black))
                        ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Ngày chứng từ : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: formatDate(content.issueDate!),
                              style: const TextStyle(color: Colors.black))
                        ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Phòng ban bàn giao : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: content.handoverDepartmentName ?? "",
                              style: const TextStyle(color: Colors.black))
                        ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Phòng ban tiếp nhận : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: content.receiverDepartmentName!,
                              style: const TextStyle(color: Colors.black))
                        ])),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  String formatDate(int issueDate) {
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(issueDate);
    return DateFormat('dd/MM/yyyy').format(datetime);
  }
  String status(int? allocationStatusIndex){
    switch(allocationStatusIndex){
      case 1 : return "Đã cấp phát";
      case 2 : return "Trả về";
      case 0 : return "Mới cấp";
      default : return "";
    }
  }
  Color color(int? allocationStatusIndex){
    switch(allocationStatusIndex){
      case 1 : return Colors.deepPurple;
      case 2 : return Colors.blue;
      case 0 : return Colors.green;
      default : return Colors.white;
    }
  }
}
