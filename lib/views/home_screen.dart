import 'package:ban_sach/preferences_service.dart';
import 'package:ban_sach/setting.dart';
import 'package:flutter/material.dart';
import 'package:ban_sach/views/exit_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double kc = 200;
  final _preferencesService = PreferencesService();
  double giamGia = 1;
  bool value = false;
  TextEditingController? mathController;
  TextEditingController? litController;
  TextEditingController? englishController;
  TextEditingController? tinhTTController;
  int thanhTien = 0;
  String loai = "Chua xac dinh";
  int gia = 20000;
  int _customer = 0;
  int _customerVip = 0;
  int _revenue = 0;
  late FocusNode myFocusNode;
  void _populateFields() async {
    final setting = await _preferencesService.getSetting();
    setState(() {
      _revenue = setting.revenue;
      _customer = setting.customer;
      _customerVip = setting.customerVip;
    });
  }

  @override
  void initState() {
    super.initState();
    mathController = TextEditingController();
    litController = TextEditingController();
    englishController = TextEditingController();
    tinhTTController = TextEditingController();
    _populateFields();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
    mathController!.dispose();
    litController!.dispose();
    englishController!.dispose();
    tinhTTController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          color: const Color(0xff29b412),
          child: Column(
            children: const [
              Center(
                child: Text(
                  "Chuong trinh ban sach online",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Thong tin hoa don ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "Ten khach hang: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
                child: TextField(
                  autofocus: true,
              controller: mathController,
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "So luong sach: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: TextField(
                focusNode: myFocusNode,
                controller: tinhTTController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: kc,
            ),
            Checkbox(
              value: value,
              onChanged: (value) {
                setState(() {
                  this.value = value!;
                  print(value);
                });
              },
              activeColor: Colors.red,
              checkColor: Colors.white,
            ),
            const Text(
              "Khach hang Vip:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "Thanh tien:",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
                child: Container(
              child: Text(
                '$thanhTien',
                textAlign: TextAlign.center,
              ),
              color: Colors.black26,
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const SizedBox(width: 1,),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () {

                  if (value == true) {
                    thanhTien = 90 *
                        200 *
                        int.parse((tinhTTController!.text).toString());
                  } else {
                    thanhTien =
                        20000 * int.parse((tinhTTController!.text).toString());
                  }
              //ab    value=!value;
                },
                style: TextButton.styleFrom(
                    primary: Colors.black, backgroundColor: Colors.black26),
                child: const Text("Tinh TT"),
              ),
            ),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () {
                  myFocusNode.requestFocus();
                  if (mathController!.text != null &&
                      tinhTTController!.text != null) {
                    _customer++;
                    if (value == true) _customerVip++;
                    _revenue += thanhTien;
                    mathController!.clear();
                    tinhTTController!.clear();
                    value=!value;
                    thanhTien=0;
                    // mathController!.hasListeners;
                  } else{
                    print("Cho nay co loi");}
                  FocusScope.of(context).previousFocus();
                },
                style: TextButton.styleFrom(
                    primary: Colors.black, backgroundColor: Colors.black26),
                child: const Text("Tiep"),
              ),
            ),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Tong Doanh Thu"),
                          content: Text("$_revenue"),
                        );
                      });
                },
                style: TextButton.styleFrom(
                    primary: Colors.black, backgroundColor: Colors.black26),
                child: const Text("Thong ke"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: const Color(0xff29b412),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Thong tin thong ke ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "Tong so khach hang: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              "$_customer",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "Tong so khach hang la vip: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              "$_customerVip",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: kc,
              child: Text(
                "Tong doanh thu: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              "$_revenue",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: const Color(0xff29b412),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "",
            ),
          ),
        ),
        // Align(
        // alignment: Alignment.bottomRight,
        // child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () async {
                  SharedPreferences userData =
                      await SharedPreferences.getInstance();
                  await userData.clear();
                  await userData.remove('revenue');
                  await userData.remove('customer');
                  await userData.remove('customerVip');
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  _saveSetting();
                },
                icon: const Icon(Icons.save)),
            IconButton(
                onPressed: () {
                  showExitPopup(context);
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        // )
      ],
    )));
  }

  void _saveSetting() {
    final newSetting =
        Setting(revenue: _revenue, customer: _customer, customerVip: _customerVip);
    print(newSetting);
    _preferencesService.saveSettings(newSetting);
  }

  Widget confirmationButton({required onPressed, required String labelButton}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(labelButton),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff29b412), // Background color
        onPrimary: const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ), // Text Color (Foreground color)
      ),
    );
  }

  /*Widget informationWidget(
      {required String mathContent, required String litContent, required String englishContent}) {
    return Container(
      padding: const EdgeInsets.only(left: 30, bottom: 20, right: 10, top: 15),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("Thong tin")
              , textWidget(labelText: "Diem toan ", content: mathContent)
              , SizedBox(height: 18,)
              , textWidget(labelText: "Diem van", content: litContent)
              , SizedBox(height: 18,)
              , textWidget(labelText: "Diem anh", content: englishContent)
              , SizedBox(height: 18,)

            ],
          ),
        ),
      ),
    );
  }
*/
  textWidget({required String labelText, required String content}) {
    return Row(
      children: [
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(content),
      ],
    );
  }
}
