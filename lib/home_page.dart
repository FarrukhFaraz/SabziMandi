import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabzi_mandi/product_detail.dart';

import 'main.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loader = true;
  bool showBottomNav = false;

  List<ProductModel> list = <ProductModel>[];
  List<String> itemIds = [];

  getListData() async {
    setState(() {
      loader = true;
    });

    try {
      http.Response response = await http.get(Uri.parse(
          'https://accountpos.shoaibkanwalacademy.com/mandi_master_admin/public/api/products/all'));
      Map jsonData = jsonDecode(response.body);
      print(jsonData);

      if (jsonData['statusCode'] == 200) {
        print('Data is loaded successfully');

        for (int i = 0; i < jsonData["data"].length; i++) {
          Map<String, dynamic> object = jsonData["data"][i];
          // print('latest ==' + object.toString());
          ProductModel model = ProductModel();

          model = ProductModel.fromJson(object);
          list.add(model);
        }
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

    getListData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(234, 232, 232, 1.0),
        body: loader
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      color: Colors.white,
                      child: const Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (itemIds.contains(list[index].id.toString())) {
                              setState(() {
                                list[index].addedProduct = false;
                                itemIds.remove(list[index].id.toString());
                              });
                              print('item removed');
                            } else {
                              itemIds.add(list[index].id.toString());
                              setState(() {
                                list[index].addedProduct = true;
                              });
                              print('item added');
                            }
                            if (itemIds.isNotEmpty) {
                              setState(() {
                                showBottomNav = true;
                              });
                            } else {
                              setState(() {
                                showBottomNav = false;
                              });
                            }
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                "$imageBaseUrl${list[index].image}",
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  list[index].nameEn.toString(),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                              ),
                              list[index].addedProduct
                                  ? Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: Colors.black54,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: showBottomNav
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetail(
                      itemIds: itemIds,
                    ),
                  ));
                },
                icon: const Icon(Icons.send),
              )
            : const SizedBox(),
      ),
    );
  }
}
