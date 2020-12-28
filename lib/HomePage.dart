import 'package:TecstubTest/cellObject.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const Color textColor = Color.fromARGB(255, 237, 102, 111);

List<dynamic> data = List();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
        appBar: AppBar(
            backgroundColor:Colors.white,
          title: Center(child:Text('Home',style: TextStyle(fontWeight: FontWeight.bold,color: textColor,fontSize:20))),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () { /* Write listener code here */ },
            child: Container(
              width: 50,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () =>addHeader(),
              child:
              Container(
                width: 50,
                child:Icon(
                  Icons.add,
                  color: textColor,
                    size:30// add custom icons also
                ) ,
              ),
            ),
          ]
        ),
        backgroundColor: Colors.white,
        body:SafeArea(
            top: true,
            child:sectionView(),
        ),

    );
  }

  void addHeader(){

    if(data.length>=20){
      //Toast.show("Maximum header allow 20 only", context,duration: 3, gravity:  Toast.TOP, backgroundColor:Colors.amber, textColor:Colors.red);
      //return;
    }


    Map <dynamic,dynamic> header = Map();
    header['title']='Header ${data.length+1}';
    header['cell']=[];
    data.add(header);
    setState(() {
    });
  }


  Widget sectionView(){

    return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return tableSectionView(data[index], index);
          },
        );
  }

  Widget tableSectionView(dynamic object, int index){
    List<dynamic> totalCell = object['cell'];

    double height = (totalCell.length*50.0);
    height = height + 60; //Header Value

    return Container(
      height: height,
      child: Column(
        children: [
          header(object, index),
          innerCell(object, index),
        ],
      ),
    );
  }


  Widget innerCell(dynamic object, int indexMain){

    List<dynamic> totalCell = object['cell'];

    if(totalCell.length == 0){
      return Container();
    }

    return  ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: totalCell == null ? 0 : totalCell.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              child:cell(totalCell[index], index,object, indexMain),
            );
          },
    );
  }
  Widget cell(cellObject object, int index, dynamic mainobject, int mainIndex){

    return
       Row(
          mainAxisAlignment : MainAxisAlignment.start,
          children: [
            SizedBox(width: 30,),
            Container(
              width: 100,
             child: Align(
              alignment: Alignment.centerLeft,
              child:Text(object.title, style:TextStyle(fontWeight: FontWeight.bold,color: textColor,fontSize:20)),
             )
            ),
            GestureDetector(
              onTap: () =>changeQty(object,index,mainobject,mainIndex,true),
              child: Container(
                width: 40,
                child:Icon(
                  Icons.add,
                  color: textColor,
                  size:30// add custom icons also
                ),
              )
            ),
            Container(
              width: 60,
                child: Align(
                  alignment: Alignment.center,
                  child:textFild(object, index, mainobject, mainIndex)
                  //Text(object.qty.toString(), style:TextStyle(fontWeight: FontWeight.bold,color: textColor,fontSize:20)),
                )
            ),
            GestureDetector(
                onTap: () =>changeQty(object,index,mainobject,mainIndex,false),
                child: Container(
                  width: 40,
                  child:Icon(
                      Icons.remove,
                      color: textColor,
                      size:30// add custom icons also
                  ) ,
                )
            ),

      ],
    );
  }
  Widget textFild(cellObject object, int index, dynamic mainobject, int mainIndex) {
      return Center(
          child: TextField(
            controller: new TextEditingController.fromValue(new TextEditingValue(text: object.qty.toString(),selection: new TextSelection.collapsed(offset: object.qty.toString().length))),
            keyboardType: TextInputType.number,
             textAlign:TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),

            onChanged: (text) {
              textFildChnagesDone(object, index, mainobject, mainIndex, text);
            },
            onSubmitted: (text) {
              textFildChnagesDone(object, index, mainobject, mainIndex, text);
            },
          ));
  }

  void textFildChnagesDone(cellObject object, int index, dynamic mainobject, int mainIndex, String text) {

    int totalqty = int.parse(text);
    if(totalqty > 20)
    {
      Toast.show("Maximum qty allow 20 only", context,duration: 3, gravity:  Toast.TOP, backgroundColor:Colors.amber, textColor:Colors.red);
      return;
    }

    if(totalqty < 0)
    {
      Toast.show("Not allow nagative qty", context,duration: 3, gravity:  Toast.TOP, backgroundColor:Colors.amber, textColor:Colors.red);
      return;
    }

    List<dynamic> totalCell = mainobject['cell'];
    totalCell[index]=object;
    mainobject['cell']=totalCell;
    data[mainIndex] = mainobject;
    setState(() {

    });
  }


  void changeQty(cellObject object, int index, dynamic mainobject, int mainIndex, bool add)
  {

    if(add){
      if(object.qty>=20){
        Toast.show("Maximum qty allow 20 only", context,duration: 3, gravity:  Toast.TOP, backgroundColor:Colors.amber, textColor:Colors.red);
        return;
      }

      object.qty ++;
    }
    else{

      if(object.qty!=0)
        {
          object.qty--;
        }
    }

    List<dynamic> totalCell = mainobject['cell'];
    totalCell[index]=object;
    mainobject['cell']=totalCell;
    data[mainIndex] = mainobject;
    setState(() {

    });
  }

  Widget header(dynamic object, int index){

    return Container(
      height: 60,
      padding: EdgeInsets.only(right: 5, left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 5,),
          Row(
            mainAxisAlignment : MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10,),
              Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:Text(object['title'], style:TextStyle(fontWeight: FontWeight.bold,color: textColor,fontSize:20)),
                  )
              ),
              GestureDetector(
                onTap: () =>addCell(object,index),
                child: Container(
                  width: 50,
                  child:Icon(
                    Icons.add,
                    color: textColor,
                    size:30// add custom icons also
                ) ,
              )
              ),
            ],
          ),
          Container(
            height: 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  void addCell(dynamic object, int index){
    List<dynamic> totalCell = object['cell'];

    if(totalCell.length>=20){
     // Toast.show("Maximum item allow 20 only", context,duration: 3, gravity:  Toast.TOP, backgroundColor:Colors.amber, textColor:Colors.red);
      //return;
    }

    cellObject obj = cellObject('Cell ${totalCell.length+1}', 0);
    totalCell.add(obj);
    object['cell']=totalCell;
    data[index] = object;
    setState(() {
    });
  }
}





