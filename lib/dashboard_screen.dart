import 'dart:math';
import 'package:corpoelec_cc_demo/verify_face_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color primaryColor = const Color(0xFF233970); // 0xFFA42037 - 0xFF2C399F

  @override
  Widget build(BuildContext context) {
    // timeDilation = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)..pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFB8E1FF),
              radius: 20,
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: const Text(
                          'Última conexión: 07/08/2024',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 1,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverFixedExtentList(
                          itemExtent: 100.0,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: _buildButton(
                                  icon: const Icon(Icons.check_circle,
                                      color: Color(0xFF4A65B6)),
                                  text: Random(100 * index)
                                      .nextInt(100)
                                      .toString(),
                                  color: Colors.black,
                                ),
                              );
                            },
                            childCount: 5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required Widget icon, required String text, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // spreadRadius: 2,
            blurRadius: 5,
            // offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.receipt_sharp,
                  color: primaryColor,
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Deuda presentada: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: color,
                  ),
                ),
                Text(
                  '$text BS',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                highlightColor: null,
                splashColor: null,
                hoverColor: null,
                focusColor: null,
                color: null,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifyFaceScreen(
                        // url,
                        urlVerify:
                            'https://sandbox-payments.pagochinchin.com/66df00bd16137c6c1a241955',
                        // 'https://payments.pagochinchin.com/66db77d3f5388d35af748501/',
                        // 'https://sandbox-payments.pagochinchin.com/66db70f816137c6c1a23fa90/',
                      ),
                    ),
                  );

                  //
                },
                icon: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: primaryColor,
                  size: 24,
                )),
          ),
        ],
      ),
    );
  }
}
