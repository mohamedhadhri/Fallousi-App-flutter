import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './encours.dart';
import 'categorie.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'parametres.dart';
class confirm extends StatefulWidget {
   confirm({Key? key,this.oper_encours,this.img_link}): super(key: key);
  String? oper_encours;
 String? img_link;
  @override
  State<confirm> createState() => _confirmState(oper_encours,img_link);
}
class _confirmState extends State<confirm> {
   _confirmState(this.oper_encours,this.img_link);
  String? oper_encours;
  String? img_link;
  String? name;
  String? nbrJ;
  String? temp ;
  String? tempf ;
  String? humd;
  String? humdf;
  String? customKey; 
void setData (data){

  setState(() {
    
    name = data['nom'];
    nbrJ = data['nombre_jour'];
    temp = data['tempurature_ideale'];
    humd = data['humidite_ideale'];
    tempf = data['temperature_finale'];
    humdf = data['humidite_finale'];
  });
}
void setData2 (data){

  print('*************');
  print(data.length);
  print('*************');
  setState(() {
    customKey = (data.length ).toString();
  });
}
  void getData (){
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('categorie/$oper_encours');
starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    
    setData(data);
});
DatabaseReference Ref =
        FirebaseDatabase.instance.ref('cycle');
Ref.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    setData2(data);
  });}
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
         final double fem = 1.0;

   return Scaffold(
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
    body: 
    SingleChildScrollView(
      child: Container(
      padding:  EdgeInsets.fromLTRB(0*fem, 30*fem, 0*fem, 0*fem),
      width:  double.infinity,
      decoration:  BoxDecoration (
      color:  Color(0xfffff1ce),
      ),
      child:  
    Column(
      crossAxisAlignment:  CrossAxisAlignment.end,
      children:  [
   Container(
  width: double.infinity,
  height: 700 * fem,
  child: Stack(
    children: [
      Positioned(
        left: 0 * fem,
        top: 57 * fem,
        right: 4 * fem,
        child: Align(
          child: SizedBox(
            width: 400 * fem,
            height: 300 * fem,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90 * fem),
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 117 * fem,
        top: 0 * fem,
        child: Align(
          child: SizedBox(
            width: 125 * fem,
            height: 114 * fem,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(87 * fem),
              child: Image.network(
                img_link ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 76 * fem,
        top: 131 * fem,
        child: Align(
          child: SizedBox(
           
            height: 27 * fem,
            child: Text(
             name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22 * fem,
                fontWeight: FontWeight.w400,
                height: 1.2175 * fem / fem,
                color: Color(0xff5c3700),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 12 * fem,
        top: 184 * fem,
        child: Align(
          child: SizedBox(
            width: 287 * fem,
            height: 81 * fem,
            child: Text(
              'Nombre de jours : $nbrJ Jours\nTempératue idéale : $temp C° \nHumidité idéale: $humd %\nTempérature finale :$tempf C°\nHumidité finale : $humdf %\n',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15 * fem,
                fontWeight: FontWeight.w400,
                height: 1.2175 * fem / fem,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 114 * fem,
        top: 434 * fem,
        child: Align(
          child: SizedBox(
            width: 126 * fem,
            height: 40 * fem,
          ),
        ),
      ),
      Positioned(
        left: 10*fem,
        top: 426*fem,
        right: 0,
        child: Align(
          child: Container(
              decoration:  BoxDecoration (
    borderRadius:  BorderRadius.circular(20*fem),
            color:  Color(0xd8f4dabb),
              ),
            child: TextButton(
              onPressed: () async {
                
                DatabaseReference ref = FirebaseDatabase.instance.ref("cycle");
                DatabaseReference ref2 = FirebaseDatabase.instance.ref("mirage").push();
var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
   
ref.child(customKey as String).set({
  "id-cat" : oper_encours,
  "date_incubation": formattedDate,
  "nmb_oeufs": '0',
  'en_cours': '0',
  
  "messure": {
    "temp_cap": {"capt_1":"10","capt_2":"20"},
    "hum_cap": {"capt_1":"10","capt_2":"20"},
    "courant_cap": "",
    "distance_cap": "",
    "eau_cap": "",
  },
  

});
ref2.set({
  "id_cycle" : customKey.toString(),
  "Premier_mirage": "",
  "deuxieme_mirage": "",
  "troisieme_mirage": "",
  "oeuf_mort": "0",
  "date_changement" :""
});
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => encours())));
              },
              child: Text(
                'Commencer',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20 * fem,
                  fontWeight: FontWeight.w400,
                  height: 1.2175 * fem,
                  color: Color(0xff5c3700),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)]))));
}}