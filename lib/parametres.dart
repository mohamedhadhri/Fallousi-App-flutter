import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'categorie.dart';
import 'encours.dart';
import 'login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class parametres extends StatefulWidget {
  _parametresState createState() => _parametresState();
}

class _parametresState extends State<parametres> {
  String? etat ;
  String? niv ;
    String? dis ;

    Future<void> setDataMesure(data) async {
  
      etat = data['courant_cap'];
      niv = data['eau_cap'];
      dis = data['distance_cap'];
    setState(() {
     etat=etat;
     niv=niv;
      dis=dis;
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
     getDataMesure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double fem = 1.0; 

    return Scaffold(
      backgroundColor: Color(0xffdea45f),
        appBar: AppBar(
        title: const Text('Couveuse'),
        backgroundColor: Color(0xb2dea35f),
     
      ),
      drawer: Drawer(
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
                       
                        backgroundImage: AssetImage('assets/falousi.png'),

                        radius:
                            50, 
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
                  )); 
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
                  )); 
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
                          parametres()))); 
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
            child: Column(children: [
                  SizedBox(height: 20),
                   Container(
            child: Text(
              'Paramètres',
                textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30 * fem,
                fontWeight: FontWeight.w400,
                height: 1.2175 * fem / fem,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
           Center(
             child: Image.network('https://cdn-icons-png.flaticon.com/128/2758/2758315.png',
                height: 150,),
           ),
            Text(
                          etat == null ? "--" : etat!,
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                  
                       Center(
             child: Image.network('https://cdn-icons-png.flaticon.com/128/9628/9628911.png',
                height: 150,),
           ),
            Text(
                       niv == null ? "--" : niv! + " %",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Container(
                          margin:  EdgeInsets.fromLTRB(28*fem, 50*fem, 21*fem, 0*fem),
                        child:
                      Text(
  'Position des plateaux',
  style:  TextStyle (
    fontFamily: 'Abhaya Libre',
    fontSize:  30*fem,
    fontWeight:  FontWeight.w400,
    height:  1.18*fem/fem,
    color:  Color.fromARGB(255, 245, 244, 244),
  ),
),
                      )
                      ,
Container(
  margin:  EdgeInsets.fromLTRB(28*fem, 30*fem, 21*fem, 0*fem),
  width:  double.infinity,
  height:  190*fem,
  decoration:  BoxDecoration (
    border:  Border.all(
      width:  1*fem,
      color:  Color(0xff000000),),
    color:  Color(0xfff5f5f5),
    borderRadius:  BorderRadius.circular(10*fem),
    boxShadow:  [
      BoxShadow(
        color:  Color(0x3f000000),
        offset:  Offset(0*fem, 4*fem),
        blurRadius:  2*fem,
      ),
    ],
  ),
  child:  
Center(
  child:  
Text(
   dis == null ? "--" : dis!.toString().toUpperCase(),
  style:  TextStyle (
    fontFamily: 'Abhaya Libre',
    fontSize:  20*fem,
    fontWeight:  FontWeight.w400,
    height:  1.18*fem/fem,
    color:  Color(0xff000000),
  ),
),
),
),
  ],
         )));
  }}