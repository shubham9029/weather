import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wather/screen/home/model/home_model.dart';
import 'package:wather/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController txtName=TextEditingController();
  HomeProvider? providerR;
  HomeProvider? providerW;
  @override
  void initState() {

    super.initState();
    context.read<HomeProvider>().weathergetData("Surat");
  }
  @override
  Widget build(BuildContext context) {
    providerR=context.read<HomeProvider>();
    providerW=context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              bottom();
            },
            icon: const Icon(Icons.bookmark),
          ),
          providerW!.homeModel != null
              ? IconButton(
              onPressed: () {
                providerW!.setData(providerW!.homeModel!.name!);
              },
              icon: const Icon(Icons.favorite))
              : Container(),
          IconButton(onPressed: () {
            providerR!.setTheme();

          }, icon: Icon(providerW!.theme==true?Icons.light_mode:Icons.dark_mode))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            FutureBuilder(
              future: context.watch<HomeProvider>().model,
              builder: (context, snapshot) {
                if(snapshot.hasError)
                {
                  Text("${snapshot.error}");
                }
                else if(snapshot.hasData)
                {
                  HomeModel? model = snapshot.data;
                  if(model==null)
                  {
                    const Text("Not Available");
                  }
                  else
                  {
                    return Center(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchBar(
        
                                controller:txtName ,
                                hintText: "Search City",
                                trailing: [
                                  IconButton(onPressed: () {
                                    context.read<HomeProvider>().weathergetData(txtName.text);
                                  }, icon: const Icon(Icons.search))
                                ],
                              ),
                            ),
                            Image.asset("assets/image/11.png"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                Center(child: Text("${model.name}",style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 30
                                ),),),
                                SizedBox(height: 10,),
                                Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Latitude:${model.coordModel!.lat}"),
                                )),
                              ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("${model.mainModel!.temp}",style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.blueAccent
                                  ),)),
                                ),
                                SizedBox(height: 10,),
                                Center(child: Text("Logitude:${model.coordModel!.lon}")),
                              ],),
        
                            ),
                            Container(
                              height: 270,
                              width:550,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               color: Colors.blue.shade900,
                             ),
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: providerR!.l1.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3
                              ), itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(6),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(0.50)
                                  ),
        
                                  // height: 10,
                                  // width: 10,
        
                                  child: Column(
                                    children: [
                                      Text("${providerR!.l1[index]}"),
                                      Text("${providerR!.l2[index]}"),
                                      Image.asset("assets/image/12.png",height: 50,)
                                    ],
                                  ),
                                );
                              },),
                            )
                          ],
                        ),
                      ) ,
        
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
        
            ),
        
          ],
        
        ),
      ),
      drawer: Drawer(),
    );

  }
  void bottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Favourite City",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: providerW!.l3.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          providerW!.weathergetData(providerW!.l3[index]);
                          Navigator.pop(context);
                        },
                        title: Text("${providerW!.l3[index]}"),
                        trailing: IconButton(
                          onPressed: () {
                            providerW!.deleteContact(index);
                            providerW!.getData();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}