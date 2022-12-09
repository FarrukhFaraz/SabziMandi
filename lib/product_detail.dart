import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabzi_mandi/unit_model.dart';

import 'main.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.itemIds,
  }) : super(key: key);

  final List<String> itemIds;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<UnitModel> list = <UnitModel>[];
  bool loader = false;
  String? value;

  getUniListApi() async {
    setState(() {
      loader = true;
    });
    Map body = {
      "product_id": jsonEncode(widget.itemIds),
    };

    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://accountpos.shoaibkanwalacademy.com/mandi_master_admin/public/api/products/multiple-dependent/unit'),
          body: body);

      Map jsonData = jsonDecode(response.body);
      print(jsonData);

      if (jsonData['statusCode'] == 200) {
        print('Data is loaded successfully');

        for (int i = 0; i < jsonData["data"].length; i++) {
          Map<String, dynamic> object = jsonData["data"][i];
          // print('latest ==' + object.toString());
          UnitModel model = UnitModel();

          model = UnitModel.fromJson(object);
          list.add(model);
        }
        print(list.length);
      } else {
        print('Data not loaded check condition');
      }
    } catch (e) {
      print(e);
      print('something went wrong');
    }

    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUniListApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.black12,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              // horizontal: MediaQuery.of(context).size.width*0.03,
              // vertical: 15
              ),
          child: Column(
            children: [
              Material(
                elevation: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  height: 60,
                  color: Colors.black12,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Merchant:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Material(
                elevation: 1,
                child: Container(
                  height: 60,
                  color: Colors.green,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.center, child: Text('Name')),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('Quantity')),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('Unit')),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('Price')),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('InCity')),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('Out of\n City')),
                      ),
                    ],
                  ),
                ),
              ),
              loader
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: const CircularProgressIndicator(),
                    )
                  : Container(
                      color: Colors.black12,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 2),
                                            child: Text(
                                              list[index].name.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            backgroundImage: NetworkImage(
                                              imageBaseUrl +
                                                  list[index].image.toString(),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${list[index].quantity}'),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      list[index].quantity++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                      Icons.arrow_drop_up)),
                                              list[index].quantity > 1
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          list[index]
                                                              .quantity--;
                                                        });
                                                      },
                                                      child: const Icon(Icons
                                                          .arrow_drop_down))
                                                  : const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.grey,
                                                    ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: DropdownButton(
                                      itemHeight: 50.0,
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      style: const TextStyle(fontSize: 12,color: Colors.black),
                                      hint: const Text('Choose',style: TextStyle(fontSize: 12),),
                                      value: list[index].dropDownUnitValue,
                                      onChanged: (e) {
                                        setState(() {
                                          list[index].dropDownUnitValue=e.toString();
                                        });
                                      },
                                      items: list[index]
                                          .productPacking![0]
                                          .packing!
                                          .units!
                                          .map((val) {
                                        return DropdownMenuItem(
                                          value: val.id.toString(),
                                          child: Text(val.nameEn.toString()),

                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                   // height: 40,
                                      alignment: Alignment.center,
                                      child: const TextField(
                                        autofocus: false,
                                        //cursorHeight: 10,
                                        decoration: InputDecoration(
                                          isDense: true,
                                        ),
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        list[index].inCity = true;
                                        list[index].outCity = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: list[index].inCity
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            )
                                          : Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        list[index].outCity = true;
                                        list[index].inCity = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: list[index].outCity
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            )
                                          : Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
