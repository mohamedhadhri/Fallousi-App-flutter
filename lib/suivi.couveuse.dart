// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:count_stepper/count_stepper.dart';
import 'parametres.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'categorie.dart';
import 'encours.dart';
import 'login.dart';

class Suivicouveuse extends StatefulWidget {
  @override
  _SuivicouveuseState createState() => _SuivicouveuseState();
}

class _SuivicouveuseState extends State<Suivicouveuse> {
  TextEditingController mb_oeufs = TextEditingController();
  final _preMirage = TextEditingController();
  final _deuxMirage = TextEditingController();
  final _troisMirage = TextEditingController();
  final _Changement = TextEditingController();

  TextEditingController dateController = TextEditingController();
  int? oeuf_mort;
  String? dateInc;
  String? nbrJ;
  String? dateEco;
void getCatData(data){
   
   setState(() {
nbrJ = data['nombre_jour'];
dateEco = DateFormat('dd-MM-yyyy').format(DateTime.parse(dateInc!).add(Duration(days: int.parse(nbrJ!))));
   });

}
  void setData(data) {
    final childrenList = data.values.toList();
    final lastChild = childrenList.last;
    final cat = lastChild['id-cat'];
 DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('categorie/$cat');
starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    
    getCatData(data);
});
    setState(() {
      mb_oeufs.text = lastChild['nmb_oeufs'].toString();
        _Changement.text = lastChild['date_changement'].toString();
      dateInc = lastChild['date_incubation'].toString();
      
    });
  }

  void setData2(data) {
    final childrenList = data.values.toList();
    final lastChild = childrenList.last;

    setState(() {
      _preMirage.text = lastChild['Premier_mirage'].toString();
      _deuxMirage.text = lastChild['deuxieme_mirage'].toString();
      _troisMirage.text = lastChild['troisieme_mirage'].toString();
      oeuf_mort = int.parse(lastChild['oeuf_mort'].toString());
      _Changement.text = lastChild['date_changement'].toString();
    });
  }

  void getData() {
    DatabaseReference mesRef = FirebaseDatabase.instance.ref('cycle');
    mesRef.limitToLast(1).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setData(data);
      DatabaseReference mirRef = FirebaseDatabase.instance.ref('mirage');
      mirRef.limitToLast(1).onValue.listen((DatabaseEvent event) {
        final data2 = event.snapshot.value;
        setData2(data2);
      });
    });
  }

  @override
  void initState() {
    dateController.text = "";
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                      builder: ((context) =>parametres()))); 
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
            color: Color(0xffdea45f),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Date d’incubation :     ',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF4DABB),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        
                      )
                      ,child: Padding(
                        padding: const EdgeInsets.only(top:15,bottom: 15,left: 8,right: 8),
                        child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(dateInc!)),style: TextStyle(fontSize: 18),),
                      ),),
                    ],
                  ),
                  Table(
                      border: TableBorder(left: BorderSide(width: 5)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Text('Nombre des oeufs',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500))
                          ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextField(
                                      controller: mb_oeufs,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          fillColor: Color(0xffF4DABB),
                                          filled: true,
                                          hintText: 'Oeufs'),
                                    ),
                                  ),
                                )
                              ]),
                        ]),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Mirage',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
                      border: TableBorder(left: BorderSide(width: 5)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text('Premier mirage : ',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          Column(children: [
                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextField(
                                  controller:
                                      _preMirage, 
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                     iconColor: Color.fromARGB(255, 51, 51, 51),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fillColor: Color(0xffF4DABB),
                                      filled: true,
                                      labelText: '1 er Mirage',
                                      hintText: '1 er Mirage'),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.now(), //get today's date
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        _preMirage.text =
                                            formattedDate; //set foratted date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text('Deuxieume mirage : ',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          Column(children: [
                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextField(
                                  controller:
                                      _deuxMirage, //editing controller of this TextField
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                     iconColor: Color.fromARGB(255, 51, 51, 51),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fillColor: Color(0xffF4DABB),
                                      filled: true,
                                      labelText: '2 eme Mirage',
                                      hintText: '2 eme Mirage'),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.now(), //get today's date
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        _deuxMirage.text =
                                            formattedDate; //set foratted date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                )
                              ),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text('Troisiéme mirage : ',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          Column(children: [
                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextField(
                                  controller:
                                      _troisMirage, //editing controller of this TextField
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                     iconColor: Color.fromARGB(255, 51, 51, 51),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fillColor: Color(0xffF4DABB),
                                      filled: true,
                                      labelText: '3 eme Mirage',
                                      hintText: '3 eme Mirage'),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.now(), //get today's date
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        _troisMirage.text =
                                            formattedDate; //set foratted date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text('Oeufs morts :',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          Column(children: [
                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CountStepper(
                                  iconColor: Colors.white,
                                  defaultValue: oeuf_mort as int,
                                  iconIncrementColor: Color(0xffF4DABB),
                                  iconDecrementColor: Color(0xffF4DABB),
                                  splashRadius: 25,
                                 
                                  onPressed: (value) {
                                    setState(() {
                                      oeuf_mort = value;
                                    });
                                  
                                  },
                                ),
                              ),
                            )
                          ]),
                        ]),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Changement du plateau:',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextField(
                                  controller:
                                      _Changement, //editing controller of this TextField
                                  decoration: InputDecoration(
                                
                                     iconColor: Color.fromARGB(255, 51, 51, 51),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fillColor: Color(0xffF4DABB),
                                      filled: true,
                                      labelText: 'Change',
                                      hintText: 'Change'),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.now(), //get today's date
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        _Changement.text =
                                            formattedDate; //set foratted date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Date d’éclosion :       ',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF4DABB),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        
                      )
                      ,child: Padding(
                        padding: const EdgeInsets.only(top:15,bottom: 15,left: 8,right: 8),
                        child: Text(dateEco!,style: TextStyle(fontSize: 18),),
                      ),),
                    ],
                  ),
                  SizedBox(height: 50,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5C3700),
                        fixedSize: Size(250, 50)
                      ),
                      onPressed: () async {
                        Query query = FirebaseDatabase.instance.ref('mirage').limitToLast(1);
query.once().then((DatabaseEvent event) {
  if (event.snapshot.value != null) {
    Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
    String lastElementKey = data.keys.first;
    dynamic lastElementValue = data[lastElementKey];
    FirebaseDatabase.instance.ref().child('mirage').child(lastElementKey).update({
      'Premier_mirage':   _preMirage.text,
      'deuxieme_mirage': _deuxMirage.text,
      'troisieme_mirage': _troisMirage.text,
      'oeuf_mort': oeuf_mort,
      'date_changement':_Changement.text,
    });
  }
});

Query query2 = FirebaseDatabase.instance.ref('cycle').limitToLast(1);
query2.once().then((DatabaseEvent event) {
  if (event.snapshot.value != null) {
    Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
    String lastElementKey = data.keys.first;
    dynamic lastElementValue = data[lastElementKey];
    FirebaseDatabase.instance.ref().child('cycle').child(lastElementKey).update({
      'nmb_oeufs':   mb_oeufs.text,
      
    });
  }
});

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Enregistrer'),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
