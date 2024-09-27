import 'package:first/main.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final data;
  const Details ({super.key , this.data});
  @override
  State<Details> createState() => _DetailPageState(); // Make sure the state matches the widget
}
class _DetailPageState extends State<Details> { // Corrected: State<Homepage>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor:Colors.grey[200],
        title:Row(
          mainAxisAlignment:MainAxisAlignment.center,
            children:[
          Icon(Icons.electric_meter_outlined , color:Colors.black ),
          Text(" Ecom "),
          Text("Menna" , style:TextStyle(color:Colors.orange)),
        ]),
        iconTheme:IconThemeData(
          color:Colors.grey[500],
        ) ,
      ) ,
      endDrawer: Drawer(),
      body:ListView(
        children:[
          Container(
            color:Colors.grey[200],
            height:400,
              child:Image.asset(widget.data["image"])
          ),
          Container(
              child:Text(widget.data["name"] , textAlign:TextAlign.center ,
              style: TextStyle(fontWeight:FontWeight.bold , fontSize:35),)),
          Container(
              child:Text(widget.data["dis"] , textAlign:TextAlign.center ,
                style: TextStyle(fontSize:25 ,color:Colors.grey),)),
          SizedBox(height:15),
          Container(
              child:Text(widget.data["price"] , textAlign:TextAlign.center ,
                style:TextStyle(fontWeight:FontWeight.bold,fontSize:30,color:Colors.orange),)),
          SizedBox(height:25),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text("Color:",style:TextStyle(color:Colors.grey ,
                    fontSize:20, fontWeight:FontWeight.bold)),
                SizedBox(width:25),
                Container(
                  width:30,
                  height:30,
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(100),
                    border:Border.all(color:Colors.orange ),
                    color:Colors.grey,
                  ),),
                SizedBox(width:7),
                Text("Grey",style:TextStyle(color:Colors.grey , fontSize:20)),
                SizedBox(width:20),
                Container(
                  width:30,
                  height:30,
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(100),
                    color:Colors.black,
                  ),),
                SizedBox(width:7),
                Text("Black",style:TextStyle(color:Colors.grey , fontSize:20)),
          ]),
          SizedBox(height:20),
          Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text("Size:",style:TextStyle(color:Colors.grey ,
                    fontSize:20, fontWeight:FontWeight.bold)),
                SizedBox(width:35),
                Text("39" ,style:TextStyle(fontSize:18)),
                SizedBox(width:20),
                Text("40" , style:TextStyle(fontSize:18, color:Colors.grey)),
                SizedBox(width:20),
                Text("41" ,style:TextStyle(fontSize:18 , color:Colors.grey)),
                SizedBox(width:20),
                Text("42" , style:TextStyle(fontSize:18,color:Colors.grey)),
                SizedBox(width:20),
                Text("43",style:TextStyle(fontSize:18,color:Colors.grey)),
              ]
          ),
          SizedBox(height:20),
        Container(
          margin:EdgeInsets.symmetric(horizontal:80),
            child:MaterialButton(
                color:Colors.black,
                height:50,
                onPressed:() {},
                child:Text("Add To Cart", style: TextStyle(color: Colors.white , fontSize:20))
            )),
        ]),
      bottomNavigationBar: BottomNavigationBar(
          iconSize:40,
          selectedItemColor:Colors.orange,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home , color:Colors.black) , label:"*"),
            BottomNavigationBarItem(icon:Icon(Icons.shopping_bag_outlined, color:Colors.black) , label:"*"),
            BottomNavigationBarItem(icon:Icon(Icons.person_2_outlined, color:Colors.black) , label:"*")

          ]),

    );
  }
}