
import 'login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'commencer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'encours.dart';
import 'parametres.dart';

class categorie extends StatelessWidget {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  DatabaseReference db_Ref =
        FirebaseDatabase.instance.ref().child('categorie');
  @override
  Widget build(BuildContext context) {
        final double fem = 1.0; // Set the value of fem to an appropriate value
      List cat = [['Dinde','https://jardinage.lemonde.fr/images/dossiers/2017-04/dinde-141047.jpg'],
      ['Poule','https://jardinage.lemonde.fr/images/dossiers/2018-06/poule-rousse-082903.jpg'],
      ['Canard de barbarie','https://media.gerbeaud.net/2020/07/640/canard-barbarie-male.jpg'],
       ['Canard de domestique','https://www.oiseaux.net/photos/nathalie.santa.maria/images/id/canard.colvert.nasa.1p.300.w.jpg'],
        ['Faison','https://jardinage.lemonde.fr/images/dossiers/2017-03/faisan-115354.jpg'],
         ['Oie','https://upload.wikimedia.org/wikipedia/commons/3/34/Anser_anser_1_%28Piotr_Kuczynski%29.jpg'],
          ['Paon','https://jardinage.lemonde.fr/images/dossiers/2017-12/paon-1-083116.jpg']];
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
                height: 250,
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()))
                  ,
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
          // androidsmall5S2W (1:55)
          padding:  EdgeInsets.fromLTRB(25*fem, 33*fem, 25*fem, 100*fem),
          width:  double.infinity,
          height:750,
          decoration:  BoxDecoration (
          color:  Color(0xfffff1ce),
          ),
          child:  
            Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:  [
           
            Container(
          
          child:  
            Text(
          'Catégories',
          style:  TextStyle (
           fontFamily: 'Montserrat',
          fontSize:  30*fem,
          fontWeight:  FontWeight.w400,
          height:  1.2175*fem/fem,
          color:  Color(0xff000000),
          ),
            ),
            ),
        
            
        
            
              FirebaseAnimatedList(
              query: db_Ref,
              shrinkWrap: true,
              itemBuilder: (context, snapshot, animation, index) {
          Map Contact = snapshot.value as Map;
          Contact['key'] = snapshot.key;
          return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: 
                        CircleAvatar(
          backgroundImage: NetworkImage(Contact['url'],
          ),
          radius: 50, // adjust the radius as needed
        ),
                        
                        trailing: Icon( Icons.arrow_forward),
                        title: Text(Contact['nom']),
                        onTap: () async {
              
                          print(Contact['nom']);Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => confirm(oper_encours: Contact['key'],img_link: Contact['url'],)),
                    )); },
                        ),
                  );
                     
          
          })
              ],
            ),),
        )
   );
  }
}