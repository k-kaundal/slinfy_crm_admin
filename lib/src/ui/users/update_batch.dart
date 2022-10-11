import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';

class UpdateBatch extends StatefulWidget {
  String id;

  UpdateBatch({Key? key, this.id = ''}) : super(key: key);

  @override
  State<UpdateBatch> createState() => _UpdateBatchState();
}

class _UpdateBatchState extends State<UpdateBatch> {
  List batches = [];
  String batch = '';

  @override
  void initState() {
    // TODO: implement initState
    DatabaseService().getBasicData().listen((event) {
      setState(() {
        batches.clear();
        batches.addAll(event.get('Batches'));
        batch = batches[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.id),
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: batch.isNotEmpty ? batch : "Demo",
                items: List.generate(
                  batches.length,
                  (index) => DropdownMenuItem(
                    value: batches[index],
                    child: Text(batches[index]),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    batch = value.toString();
                  });
                },
              ))
            ],
          )),
    );
  }
}
