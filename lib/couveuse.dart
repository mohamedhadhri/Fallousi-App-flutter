import 'suivi.couveuse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'categorie.dart';
import 'encours.dart';
import 'login.dart';
import 'parametres.dart';

class couveuse extends StatefulWidget {
  couveuse({Key? key, this.oper_encours, this.img_link}) : super(key: key);
  String? oper_encours;
  String? img_link;
  @override
  State<couveuse> createState() => _couveuseState(oper_encours, img_link);
}

class _couveuseState extends State<couveuse> {
  _couveuseState(this.oper_encours, this.img_link);
  String? oper_encours;
  String? img_link;
  String? temp;
  String? temp2;
  String? hum;
  String? hum2;
  String? date;
  String? url;
  String? nb;
  String? inf;

  Future<void> setData(data) async {
    final childrenList = data.values.toList();
    final lastChild = childrenList.last;
    final ref = FirebaseDatabase.instance.ref();
    final cat = lastChild['id-cat'];
    final snapshot = await ref.child('categorie/$cat/url').get();
    final snapshot2 = await ref.child('categorie/$cat/info').get();
    setState(() {
      nb = lastChild['nmb_oeufs'];
      url = snapshot.value.toString();
      inf = snapshot2.value.toString();
    });
  }

  Future<void> setDataMesure(data) async {
    temp = data['temp_cap']['capt_1'];
    temp2 = data['temp_cap']['capt_1'];
    hum = data['hum_cap']['capt_1'];
    hum2 = data['hum_cap']['capt_1'];
    setState(() {
      temp = temp;
      temp2 = temp2;
      hum = hum;
      hum2 = hum2;
    });
  }

  Future<void> getData() async {
    final ref = FirebaseDatabase.instance.ref();
    DatabaseReference mesRef = FirebaseDatabase.instance.ref('cycle');
    mesRef.limitToLast(1).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setData(data);
    });
  }

  Future<void> getDataMesure() async {
    final ref = FirebaseDatabase.instance.ref();
    DatabaseReference mesRef = FirebaseDatabase.instance.ref('mesure');
    mesRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setDataMesure(data);
    });
  }

  @override
  void initState() {
    getData();
    getDataMesure();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double fem = 1.0; // Set the value of fem to an appropriate value

    return Scaffold(
      appBar: AppBar(
        title: const Text('Couveuse'),
        backgroundColor: Color(0xb2dea35f),
      ),
      drawer: Drawer(
        // Content of the drawer
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: UserAccountsDrawerHeader(
                  accountName: null,
                  accountEmail: null,
                  currentAccountPicture: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      child: CircleAvatar(
                        // backgroundImage: from assets not network
                        backgroundImage: AssetImage('assets/falousi.png'),

                        radius:
                            50, // Set the desired radius to enlarge the circular image
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xb2dea35f),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Accueil',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xb2dea35f),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => encours()),
                  )); // Action to be performed for option 1
                },
                leading: Icon(Icons.home),
              ),
              SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Catégories',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xb2dea35f),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => categorie()),
                  )); // Action to be performed for option 2
                },
                leading: Icon(Icons.category),
              ),
              SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xb2dea35f),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) =>
                          parametres()))); // Action to be performed for option 3
                },
                leading: Icon(Icons.settings),
              ),
              SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xb2dea35f),
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                leading: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: 800,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffdea45f),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(

                  padding: EdgeInsets.fromLTRB(
                      13 * fem, 23 * fem, 10 * fem, 1 * fem),

                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 5 * fem),

                        width: double.infinity,

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 40 * fem, 2 * fem),

                              width: 116 * fem,

                              height: 75 * fem,

                              child: Stack(
                                children: [
                                  Positioned(

                                    left: 5 * fem,

                                    top: 30 * fem,

                                    child: Align(
                                      child: SizedBox(
                                        width: 90 * fem,
                                        height: 60 * fem,
                                        child: Text(
                                          'Jour :\n ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                          style: TextStyle(
                                            fontFamily: 'Abhaya Libre',
                                            fontSize: 20 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.18 * fem / fem,
                                            color:
                                                Color.fromARGB(255, 20, 20, 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(

                                    left: 0 * fem,

                                    top: 0 * fem,

                                    child: Align(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 181 * fem,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                   
                                   margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 30 * fem, 12 * fem),

                                    child: Text(
                                      'Température',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2175 * fem / fem,
                                        color: Color(0xffeeeeee),
                                      ),
                                    ),
                                  ),
                                  Container(

                                    width: double.infinity,

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(

                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 18 * fem, 0 * fem),

                                          child: Text(
                                            'Capteur1',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18 * fem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2175 * fem / fem,
                                              color: Color(0xff5c3700),
                                            ),
                                          ),
                                        ),
                                        Text(

                                          'Capteur2',

                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * fem / fem,
                                            color: Color(0xff5c3700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            171 * fem, 0 * fem, 16 * fem, 15 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 46 * fem, 0 * fem),
                              child: Text(
                                temp == null ? "--" : temp!.toString() + " C°",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20 * fem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2175 * fem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Text(
                              temp2 == null ? "--" : temp2!.toString() + " C°",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * fem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 90 * fem, 8 * fem),
                        child: Text(
                          'Humidité',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * fem / fem,
                            color: Color(0xffeeeeee),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            151 * fem, 0 * fem, 5 * fem, 22 * fem),
                        width: double.infinity,
                        height: 46 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 18 * fem, 0 * fem),
                              width: 80 * fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 25 * fem,
                                    top: 21 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 60 * fem,
                                        height: 25 * fem,
                                        child: Text(
                                          hum == null
                                              ? "--"
                                              : hum!.toString() + " %",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * fem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 80 * fem,
                                        height: 22 * fem,
                                        child: Text(
                                          'Capteur1',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * fem / fem,
                                            color: Color(0xff5c3700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 83 * fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 23 * fem,
                                    top: 21 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 60 * fem,
                                        height: 25 * fem,
                                        child: Text(
                                          hum2 == null
                                              ? "--"
                                              : hum2!.toString() + " %",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * fem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 83 * fem,
                                        height: 22 * fem,
                                        child: Text(
                                          'Capteur2',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * fem / fem,
                                            color: Color(0xff5c3700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 50 * fem, 10 * fem),
                        child: Text(
                          'Nombre des oeufs',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * fem / fem,
                            color: Color(0xffeeeeee),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 500 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0.004785,
                        left: 0 * fem,
                        top: 47 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 420 * fem,
                            height: 300 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70 * fem),
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 24 * fem,
                        top: 0 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 118 * fem,
                            height: 124 * fem,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(900 * fem),
                              child: Image.network(
                                url ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 28 * fem,
                        top: 195 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 127 * fem,
                            height: 25 * fem,
                            child: Text(
                              'Attention :',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * fem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 62 * fem,
                        top: 231 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 280 * fem,
                            height: 70 * fem,
                            child: Text(
                              inf ?? '',
                              style: TextStyle(
                                fontFamily: 'Abhaya Libre',
                                fontSize: 17 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.18 * fem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100 * fem,
                        top: 380 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 200 * fem,
                            height: 40 * fem,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Terminer'),
                                      content: Text(
                                          'Voulez-vous vraiment terminer la couvaison ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Query query2 = FirebaseDatabase
                                                .instance
                                                .ref('cycle')
                                                .limitToLast(1);
                                            query2
                                                .once()
                                                .then((DatabaseEvent event) {
                                              if (event.snapshot.value !=
                                                  null) {
                                                Map<dynamic, dynamic> data =
                                                    event.snapshot.value as Map<
                                                        dynamic, dynamic>;
                                                String lastElementKey =
                                                    data.keys.first;
                                                dynamic lastElementValue =
                                                    data[lastElementKey];
                                                FirebaseDatabase.instance
                                                    .ref()
                                                    .child('cycle')
                                                    .child(lastElementKey)
                                                    .update({
                                                  'en_cours': '1'
                                                }).then((value) =>
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                ((context) =>
                                                                    encours()),
                                                          ),
                                                        ));
                                              }
                                            });
                                          },
                                          child: Text('Terminer'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 207, 185, 154),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50 * fem),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Terminer'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13 * fem,
                        top: 139 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 330 * fem,
                            height: 39 * fem,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50 * fem),
                                  color: Color(0xffdea45f),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 98 * fem,
                        top: 148 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 166 * fem,
                            height: 40 * fem,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => Suivicouveuse()),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Suivi de couvaison',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w400,
                                  height: 0.005 * fem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 215 * fem,
                        top: 4 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 60 * fem,
                            height: 31 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50 * fem),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 235 * fem,
                        top: 7 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 25 * fem,
                            height: 25 * fem,
                            child: Text(
                              nb == null ? "--" : nb!,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * fem / fem,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
