import 'package:first/details.dart';
import 'package:first/main.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomePageState(); // Make sure the state matches the widget
}

class _HomePageState extends State<Homepage> { // Corrected: State<Homepage>
 List category = [
     {"iconname":Icons.laptop, "title" : "Laptop"},
   {"iconname":Icons.phone_android, "title" : "Mobile"},
   {"iconname":Icons.electric_bike, "title" : "Bike"},
   {"iconname":Icons.card_giftcard_outlined,"title":"Gift"},
   {"iconname":Icons.watch_outlined,"title":"Watch"},
   {"iconname":Icons.earbuds,"title":"Earbuds"}
 ];
 List items = [
   {"image":"images/manwatch.jpg","name":"Man Watch","dis":"model 302","price":"250\$"},
   {"image":"images/laptop.jpg","name":"Laptop","dis":"HP Lap","price":"25000\$"},
   {"image":"images/earbuds.jpg","name":"Earbuds","dis":"model 112","price":"30\$"},
   {"image":"images/earphone.jpg","name":"Earphone","dis":"model 332","price":"99\$"},
   {"image":"images/diamondWatch.jpg","name":"Diamond Watch","dis":"model 102","price":"2000\$"},
   {"image":"images/diamondWatch2.jpg","name":"Diamond Watch","dis":"model 592","price":"2500\$"},
   {"image":"images/Dring.jpg","name":"Diamond Ring","dis":"model 657","price":"3000\$"},
   {"image":"images/Dring2.jpg","name":"Diamond Ring","dis":"model 542","price":"1500\$"},
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize:40,
          selectedItemColor:Colors.orange,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home , color:Colors.black) , label:"*"),
            BottomNavigationBarItem(icon:Icon(Icons.shopping_bag_outlined, color:Colors.black) , label:"*"),
            BottomNavigationBarItem(icon:Icon(Icons.person_2_outlined, color:Colors.black) , label:"*")
          ]),
        body:Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(children: [
                Expanded(
                    child:TextFormField(
                      decoration:InputDecoration(
                        prefixIcon:Icon(Icons.search),
                        hintText:"Search" ,
                        border:InputBorder.none,
                        filled:true,
                        fillColor: Colors.grey[200],
                      ),
                    )
                ),
                Padding(
                    padding:EdgeInsets.only(left:10),
                    child:Icon(Icons.menu, size:45)
                )]),
              SizedBox(height:30),
              Text("Categories" , style:TextStyle(fontWeight:FontWeight.bold , fontSize:25)),
              SizedBox(height:20),
              Container(
                height:145,
                child:ListView.builder(
                  itemCount: category.length,
                  scrollDirection:Axis.horizontal,
                  itemBuilder: (context ,i ){
                    return Container(
                      margin:EdgeInsets.only(right:15),
                      child:Column(
                          children:[
                        Container(
                          padding:EdgeInsets.all(15),
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(100),
                            color:Colors.grey[200],
                          ),
                          child:Icon(category[i]["iconname"] , size:50),
                        ),
                        Text(category[i]["title"] , style:TextStyle(fontWeight:FontWeight.bold , fontSize:20,color:Colors.grey[800]))
                      ]),
                    );})),
              Text("Best Silling " , style:TextStyle(fontWeight:FontWeight.bold , fontSize:25)),
              SizedBox(height:20),
              GridView.builder(
                  itemCount:items.length  ,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , mainAxisExtent:230),
                  itemBuilder:(context , i){
                    return InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute
                          (builder:(context)=>Details(data: items[i])));
                      },
                      child:Card(
                        child:Column(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                            children:[
                              Container(
                                  width:300,
                                  color:Colors.grey[200],
                                  child:Image.asset(items[i]["image"],height:130, fit:BoxFit.cover, )),
                              Text(items[i]["name"] , style:TextStyle( fontWeight:FontWeight.bold)),
                              Text(items[i]["dis"],style:TextStyle(fontSize:14 , color:Colors.grey)),
                              Text(items[i]["price"], style:TextStyle(fontSize:14 , color:Colors.orange ,
                                  fontWeight:FontWeight.bold))
                            ]
                        )
                      )) ;
                  })
            ]
          )
        )
    );
  }
}
