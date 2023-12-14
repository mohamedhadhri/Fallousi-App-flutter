// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'parametres.dart';
import 'categorie.dart';
import 'couveuse.dart';
import 'suivi.fini.dart';
import 'package:firebase_core/firebase_core.dart';

class encours extends StatefulWidget {
  encours({Key? key, this.oper_encours, this.img_link}) : super(key: key);
  String? oper_encours;
  String? img_link;
  @override
  State<encours> createState() => _encoursState(oper_encours, img_link);
}

class _encoursState extends State<encours> {


Future<void> iniss() async {
FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);


}



  final user = FirebaseAuth.instance.currentUser!;
  String en_cours = 'AAAAA';
  List CompletedList = [];
  List CompletedList1 = [];
  List CompletedList2 = [];
  List CompletedList3 = [];
  List CatList = [];
  _encoursState(this.oper_encours, this.img_link);
  String? oper_encours;
  String? img_link;
  String? name;
  String? url;
  String? enco;
  String? nbrJ;
  String? temp;
  String? date;

  Future<void> getCats() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('categorie').get();
    if (snapshot.exists) {
      setState(() {
        CatList = snapshot.value as List;
      });
    } else {
      print('No data available.');
    }
  }

  Future<void> setData(data) async {
    final childrenList = data.values.toList();
    print('----------------');
    print(childrenList);
    print('----------------');
    final lastChild = childrenList.last;

    final cat = lastChild['id-cat'];
    print(cat);
    date = lastChild['date_incubation'];
    enco = lastChild['en_cours'];

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('categorie/$cat/nom').get();
    final snapshot2 = await ref.child('categorie/$cat/url').get();
    if (snapshot.exists) {
      setState(() {
        name = snapshot.value as String;
        url = snapshot2.value as String;
      });
    } else {
      print('No data available.');
    }
  }

  void setCompleted(data) {
  setState(() {
    CompletedList1 = data.values.toList();
   CompletedList2 = CompletedList1.reversed.toList();
  });
  print("****************");
   
      for (var i = 0; i < CompletedList2.length; i++) {
        if (CompletedList2[i]['en_cours'] == "1") {
        CompletedList3.add(CompletedList2[i]);
        print(CompletedList2[i]['id-cat']);
        }
      }
      print("****************");
     
      setState(() {
        CompletedList = CompletedList3;
      });
  }

  void getDCompleted() {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('cycle');
    starCountRef.limitToLast(4).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setCompleted(data);
    });
  }

  void getData() {
    
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('cycle');
    starCountRef.limitToLast(1).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setData(data);
    });
  }
Future<void> token() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
}
  void subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('alerts');
    print('Subscribed to topic');
  }
 
  @override
  void initState() {
     iniss();
    // TODO: implement initState
    super.initState();
    getData();
    getDCompleted();
    getCats();
    token();
    subscribeToTopic();
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
        body: SingleChildScrollView(
          child: Container(
              // androidsmall32HG (1:17)
              padding:
                  EdgeInsets.fromLTRB(25 * fem, 21 * fem, 6 * fem, 500 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffff1ce),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 230 * fem, 15 * fem),
                      child: Text(
                        'En cours :',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.bold,
                          height: 1.2175 * fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    ListTile(
                       shape: RoundedRectangleBorder(
    side: BorderSide(width: 2,color: Colors.amberAccent),
    borderRadius: BorderRadius.circular(20),
    
  ),
                      tileColor:  Color(0xff5c3700),
                      visualDensity: VisualDensity(vertical: 4),
                        leading: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(900 * fem),
                                    child: Image.network(
                                     enco! == "0" ? url! : "https://t3.ftcdn.net/jpg/02/22/14/94/360_F_222149490_gSX8XVbiwGiEGzl9mCn6An6Roy4CeqfA.jpg" ,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(enco! == "0" ? name ?? '' : "Pas d'operation",style: TextStyle(fontSize: 22),),
                        ),
                        subtitle: Text(enco! == "0" ? date ?? '' : "--/--/----"),
                        trailing: IconButton(
                          onPressed: () {
                            enco! == "0" ?
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => couveuse(
                                    oper_encours: oper_encours,
                                    img_link: img_link ?? '')),
                              ),
                            ) :  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => categorie()),
                                ),
                              );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          icon: enco! == "0" ? Icon(Icons.arrow_forward_ios) : Icon(Icons.add,size: 30,),
                        
                        )
                    ),
                    SizedBox(height: 50,),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 230 * fem, 6 * fem),
                      child: Text(
                        'Complète :',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.bold,
                          height: 1.2175 * fem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 21 * fem),
                      width: double.infinity,
                      height: 121 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 380,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3, 

                              itemBuilder: (context, index) {
                                String? name2 = "";
                                String? url2 = "";
                                final currentItem = CompletedList[index];
                                final id_cat = currentItem['id-cat'].toString();
                                return Container(
                                  
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 6 * fem, 3 * fem),
                                  width: 104 * fem,
                                  height: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0 * fem,
                                        top: 4 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 95 * fem,
                                            height: 111 * fem,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10 * fem),
                                                border: Border.all(
                                                    color: Color(0xff5c3700)),
                                                color: Color(0xfff5f5f5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x3f000000),
                                                    offset: Offset(
                                                        0 * fem, 4 * fem),
                                                    blurRadius: 2 * fem,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 54 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 51 * fem,
                                            height: 55 * fem,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      87 * fem),
                                              child: Image.network(
                                                CatList[int.parse(id_cat)]
                                                    ['url'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 9 * fem,
                                        top: 55 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 200 * fem,
                                            height: 30 * fem,
                                            child: Text(
                                              CatList[int.parse(id_cat)]['nom'],
                                              style: TextStyle(
                                                fontFamily: 'Abhaya Libre',
                                                fontSize: 25 * fem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.18 * fem / fem,
                                                color: Color(0xc4b77b06),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.01 * fem,
                                        top: 100 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 95 * fem,
                                            height: 12 * fem,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SuiviFini(oper_encours: index+1,)),
                                                             ),
                                                            );
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Text(
                                                'Plus d’informations',
                                                style: TextStyle(
                                                  fontFamily: 'Abhaya Libre',
                                                  fontSize: 10 * fem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.18 * fem / fem,
                                                  color: Color(0xff5c3700),
                                                ),
                                              ),
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
                    enco! != "0" ?
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 150 * fem, 15 * fem),
                      child: Text(
                        'Nouvelle incubation :',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.bold,
                          height: 1.2175 * fem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ): Container(),
                    enco! != "0" ?
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 15 * fem, 0 * fem),
                        width: 310 * fem,
                        height: 111 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff5c3700)),
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(10 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => categorie()),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Center(
                                child: Text(
                              '+',
                              style: TextStyle(
                                fontFamily: 'Abhaya Libre',
                                fontSize: 60 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.18 * fem / fem,
                                color: Color(0xffff9a03),
                              ),
                            )))):Container()
                  ])),
        ));
  }
}
