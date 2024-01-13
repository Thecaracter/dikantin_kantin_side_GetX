import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dikantin/api/service_Api.dart';
import 'package:dikantin/model/Menu_model.dart';
import '../login.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  ServiceApi serviceApi = ServiceApi();
  late Future<List<MenuApi>> listdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = serviceApi.getMenu();
    print(listdata);
  }

  Future<void> _refreshMenu() async {
    setState(() {
      listdata = serviceApi.getMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshMenu,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Group_14.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: MediaQuery.of(context).size.width / 500,
                  right: MediaQuery.of(context).size.width / 500,
                  child: Container(
                    width: 400,
                    height: 50,
                    child: Center(
                      child: Text("MENU",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    color: Color(0xffedf3f6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        offset: Offset(4, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Untuk mengganti ketersediaan menu, silahkan klik tombol ada atau tidak ada",
                            style: TextStyle(
                              color: Color(0xff514D4E),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      1.35, // Set a fixed height for the GridView
                                  child: FutureBuilder<List<MenuApi>>(
                                    future: listdata,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<MenuApi>? isimenu = snapshot.data;
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: isimenu?.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 15,
                                              childAspectRatio: 0.7,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.network(
                                                      "http://dikantin.com/" +
                                                          isimenu![index]
                                                              .foto
                                                              .toString(),
                                                      width: 50.0,
                                                      height: 50.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      isimenu[index]
                                                          .harga
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff51AADD),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      isimenu[index]
                                                          .namaMenu
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: isimenu[
                                                                        index]
                                                                    .statusStok ==
                                                                'ada'
                                                            ? Colors.green
                                                            : Color.fromARGB(
                                                                255,
                                                                228,
                                                                64,
                                                                67),
                                                      ),
                                                      onPressed: () async {
                                                        if (isimenu[index]
                                                                .statusStok ==
                                                            'ada') {
                                                          await UpdateHabisService()
                                                              .updatehabis(
                                                                  isimenu[index]
                                                                      .id
                                                                      .toString());
                                                          await _refreshMenu();
                                                        } else if (isimenu[
                                                                    index]
                                                                .statusStok ==
                                                            'tidak ada') {
                                                          await UpdateAdaService()
                                                              .updateada(isimenu[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          await _refreshMenu();
                                                        }
                                                        // Panggil fungsi sendMessage
                                                        // sendMessage(
                                                        //     'eventName',
                                                        //     'message',
                                                        //     'channelName');
                                                      },
                                                      child: Text(
                                                        isimenu[index]
                                                            .statusStok
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
