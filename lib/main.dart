import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'provider.dart';
import 'reward.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaulFirebaseOption.currentPlatform);

  runApp(SustainableLivingApp());
}




class SustainableLivingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PointsProvider(),
      child: MaterialApp(
        title: 'Greenify- Live A Sustainable Life',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NavBar(),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    EcoTipsPage(),
    RecyclingInfoPage(),
    CarbonFootprintCalculatorPage(),
    SustainableProductRecommendationsPage(),
    EcoChallengesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Eco Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recycling),
            label: 'Recycling Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Carbon Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Challenges',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pointsProvider = Provider.of<PointsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
            child: Text("Greenify",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://picsum.photos/300/200',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Sustainable Living!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  Position position = await getCurrentLocation();
                  List<RecyclingCenter> centers =
                      await getNearbyRecyclingCenters(position);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NearbyRecyclingCentersPage(recyclingCenters: centers),
                    ),
                  );
                } catch (error) {
                  print(error);
                }
              },
              child: Text('Find Recycling Centers Nearby'),
            ),
            Consumer<PointsProvider>(
              builder: (context, pointsProvider, _) {
                return Text(
                    'Total Reward Points: ${pointsProvider.totalRewardPoints}');
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RewardsPage()),
                );
              },
              child: Text('View Rewards'),
            ),
          ],
        ),
      ),
    );
  }
}

// Remaining classes remain the same

class EcoTipsPage extends StatelessWidget {
  final List<String> ecoTips = [
    "Reduce water usage by taking shorter showers.",
    "Use reusable bags instead of single-use plastic bags when shopping.",
    "Switch off lights and unplug electronic devices when not in use to save energy.",
    "Eat more plant-based meals to reduce your carbon footprint.",
    "Invest in energy-efficient appliances to save electricity.",
    "Choose products with minimal packaging to reduce waste.",
    "Support sustainable and ethical fashion brands.",
    "Reduce meat consumption to lower methane emissions from livestock farming.",
    "Use energy-efficient LED light bulbs.",
    "Unplug chargers and electronics when not in use to prevent phantom energy consumption.",
    "Shop at thrift stores or swap clothes with friends to reduce textile waste.",
    "Support renewable energy initiatives and advocate for clean energy policies.",
    "Use natural cleaning products instead of harsh chemicals.",
    "Reduce air travel and opt for video conferencing when possible to reduce emissions.",
    "Grow your own fruits, vegetables, and herbs at home.",
    "Buy in bulk to reduce packaging waste.",
    "Use a clothesline instead of a dryer to save energy and reduce emissions.",
    "Reduce consumption of single-use plastics such as straws and utensils.",
    "Shop for second-hand furniture and home goods instead of buying new items.",
    "Join community gardening projects to promote local food production.",
    "Use a reusable straw instead of disposable plastic straws.",
    "Opt for energy-efficient appliances and electronics with the ENERGY STAR label.",
    "Reduce water waste by fixing leaks and using water-saving fixtures.",
    "Support legislation and policies that promote sustainability and environmental protection.",
    "Use public transportation, walk, or bike instead of driving for short trips.",
    "Avoid products containing microbeads, which can harm marine life.",
    "Reduce paper towel waste by using cloth towels and napkins.",
    "Dispose of electronic waste responsibly by recycling or donating old electronics.",
    "Choose eco-friendly and biodegradable household cleaning products.",
    "Shop at farmers' markets to support local growers and reduce food miles.",
    "Use a reusable coffee cup instead of disposable cups.",
    "Opt for electronic tickets and boarding passes when traveling.",
    "Reduce vehicle emissions by carpooling or using public transportation.",
    "Use rechargeable batteries instead of single-use disposable batteries.",
    "Reduce plastic pollution by avoiding products with excessive packaging.",
    "Invest in energy-efficient windows and insulation to reduce heating and cooling costs.",
    "Choose organic and pesticide-free produce to support sustainable farming practices.",
    "Use a reusable lunch box and containers instead of disposable plastic bags and wrappers.",
    "Install a rain barrel to collect rainwater for gardening and landscaping.",
    "Avoid products containing palm oil, which contributes to deforestation and habitat loss.",
    "Turn off lights and electronics when leaving a room to save energy.",
    "Reduce food waste by planning meals, using leftovers, and composting.",
    "Use cloth diapers and wipes instead of disposable ones.",
    "Opt for eco-friendly transportation options such as biking or walking.",
    "Minimize food waste by composting organic matter.",
    "Choose energy-efficient appliances and electronics for your home.",
    "Use natural alternatives to chemical pesticides and fertilizers in your garden.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eco Tips'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: ecoTips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              color: Colors.lightGreenAccent,
              child: ListTile(
                title: Text(
                  ecoTips[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecyclingInfoPage extends StatelessWidget {
  final List<String> recyclingTips = [
    "- Rinse containers before recycling to remove food residue.",
    "- Check with your local recycling facility for accepted materials and sorting requirements.",
    "- Avoid putting plastic bags in recycling bins; they can jam sorting machines.",
    "- Recycle paper, cardboard, glass, plastic bottles, and metal cans whenever possible.",
    "- Consider composting organic waste such as food scraps and yard trimmings.",
    "- Dispose of hazardous materials properly; they should not be placed in recycling bins.",
    "- Reduce, Reuse, Recycle!",
    "- Bring your own reusable bags when shopping.",
    "- Recycle your old electronics at designated recycling centers.",
    "- Recycle used batteries at battery recycling locations.",
    "- Donate gently used clothing and household items to charity.",
    "- Recycle empty and clean plastic containers.",
    "- Recycle aluminum cans and foil.",
    "- Recycle clean and dry paper and cardboard.",
    "- Recycle empty and clean glass bottles and jars.",
    "- Recycle empty and clean steel and tin cans.",
    "- Recycle clean and dry plastic bags and film.",
    "- Recycle empty and dry aerosol cans.",
    "- Recycle empty and clean beverage cartons.",
    "- Recycle old newspapers and magazines.",
    "- Recycle clean and dry pizza boxes (without food residue).",
    "- Recycle old cell phones and accessories.",
    "- Recycle clean and dry milk and juice cartons.",
    "- Recycle clean and dry aluminum foil and trays.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recycling Information',
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Recycling Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Recycling guidelines and accepted materials may vary depending on your location. Here are some general tips:',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recyclingTips.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            recyclingTips[index],
                            style: TextStyle(fontSize: 16),
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
    );
  }
}

class CarbonFootprintCalculatorPage extends StatefulWidget {
  @override
  _CarbonFootprintCalculatorPageState createState() =>
      _CarbonFootprintCalculatorPageState();
}

class _CarbonFootprintCalculatorPageState
    extends State<CarbonFootprintCalculatorPage> {
  TextEditingController electricityController = TextEditingController();
  TextEditingController gasController = TextEditingController();
  TextEditingController fuelController = TextEditingController();
  double carbonFootprint = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Footprint Calculator'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Your Usage Data:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: electricityController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Electricity (kWh)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: gasController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Gas (Therms)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fuelController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Fuel (Gallons)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateFootprint,
              child: Text('Calculate Carbon Footprint'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Carbon Footprint:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              '${carbonFootprint.toStringAsFixed(2)} metric tons of CO2',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void calculateFootprint() {
    double electricity = double.tryParse(electricityController.text) ?? 0;
    double gas = double.tryParse(gasController.text) ?? 0;
    double fuel = double.tryParse(fuelController.text) ?? 0;

    double electricityFactor = 0.0006; // kg CO2 per kWh
    double gasFactor = 0.0053; // kg CO2 per therm
    double fuelFactor = 8.887; // kg CO2 per gallon

    double totalCarbon = (electricity * electricityFactor) +
        (gas * gasFactor) +
        (fuel * fuelFactor);

    setState(() {
      carbonFootprint = totalCarbon / 1000; // Convert to metric tons
    });
  }
}


class EcoChallengesPage extends StatefulWidget {
  @override
  _EcoChallengesPageState createState() => _EcoChallengesPageState();
}

class _EcoChallengesPageState extends State<EcoChallengesPage> {
  List<EcoChallenge> ecoChallenges = [
    EcoChallenge(
        title: 'Reduce Water Usage',
        description: 'Take shorter showers for a week.',
        rewardPoints: 50),
    EcoChallenge(
        title: 'Plastic-Free Week',
        description: 'Avoid using single-use plastics for a week.',
        rewardPoints: 100),
    EcoChallenge(
        title: 'Meatless Mondays',
        description: 'Eat plant-based meals every Monday for a month.',
        rewardPoints: 150),
    // Add more eco-challenges here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eco Challenges'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: ecoChallenges.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              color: Colors.lightGreenAccent,
              child: ListTile(
                title: Text(
                  ecoChallenges[index].title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(ecoChallenges[index].description),
                trailing: Consumer<PointsProvider>(
                  builder: (context, pointsProvider, child) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          if (ecoChallenges[index].completed) {
                            ecoChallenges[index].completed = false;
                            pointsProvider.updateRewardPoints(
                                -ecoChallenges[index].rewardPoints);
                          } else {
                            ecoChallenges[index].completed = true;
                            pointsProvider.updateRewardPoints(
                                ecoChallenges[index].rewardPoints);
                          }
                        });
                      },
                      child: Text(
                        ecoChallenges[index].completed ? 'Completed' : 'Complete',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          ecoChallenges[index].completed ? Colors.green : Colors.blue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PointsProvider>(
            builder: (context, pointsProvider, child) {
              return Text(
                'Total Reward Points: ${pointsProvider.totalRewardPoints}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: Center(
        child: Consumer<PointsProvider>(
          builder: (context, pointsProvider, child) {
            return Text(
              'Total Reward Points: ${pointsProvider.totalRewardPoints}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}

class EcoChallenge {
  final String title;
  final String description;
  final int rewardPoints;
  bool completed = false;

  EcoChallenge({
    required this.title,
    required this.description,
    required this.rewardPoints,
    this.completed = false,
  });
}


class NearbyRecyclingCentersPage extends StatelessWidget {
  final List<RecyclingCenter> recyclingCenters;

  NearbyRecyclingCentersPage({required this.recyclingCenters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text('Nearby Recycling Centers',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          )),
      body: ListView.builder(
        itemCount: recyclingCenters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recyclingCenters[index].name),
            subtitle: Text(
                'Distance: ${recyclingCenters[index].distance.toStringAsFixed(2)} km'),
            trailing: IconButton(
              icon: Icon(Icons.directions),
              onPressed: () {
                launchMaps(recyclingCenters[index].latitude,
                    recyclingCenters[index].longitude);
              },
            ),
          );
        },
      ),
    );
  }
}

class RecyclingCenter {
  final String name;
  final double latitude;
  final double longitude;
  double distance;

  RecyclingCenter(this.name, this.latitude, this.longitude,
      {this.distance = 0});
}

List<RecyclingCenter> recyclingCenters = [
  RecyclingCenter(
      'Eco Wise Waste Management Pvt Ltd', 28.4595, 77.0266), // Gurgaon
  RecyclingCenter('Saahas Zero Waste', 28.6139, 77.2090), // Delhi
  RecyclingCenter('Attero Recycling', 28.5355, 77.3910), // Noida
  RecyclingCenter('Earth Recycler', 28.4595, 76.0266), // Gurgaon
  RecyclingCenter('Greenobin', 28.4595, 77.0276), // Gurgaon
  RecyclingCenter('3R Recycler', 28.7041, 77.1025), // Delhi
  RecyclingCenter('GreenJams', 28.4595, 75.0366), // Gurgaon
  RecyclingCenter('Sahaas Waste Management', 28.6139, 77.2090), // Delhi
  RecyclingCenter('E-WaRDD', 28.4595, 77.4566), // Gurgaon
  RecyclingCenter('Delhi Waste Management Ltd.', 28.5204, 77.0886),
  RecyclingCenter('Okhla Waste Management Plant', 28.5246, 77.2812),
  RecyclingCenter('Faridabad Recycling Center', 28.4089, 77.3178),
  RecyclingCenter('Gurugram Waste Recycling Facility', 28.4595, 77.3266),
  RecyclingCenter('Noida Recycling Facility', 28.5355, 77.3910),
  RecyclingCenter('Ghaziabad Waste Recycling Plant', 28.6692, 77.4538),
];
void launchMaps(double latitude, double longitude) async {
  final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

Future<List<RecyclingCenter>> getNearbyRecyclingCenters(
    Position position) async {
  double userLat = position.latitude;
  double userLon = position.longitude;
  double radius = 50.0; // Radius in kilometers

  List<RecyclingCenter> nearbyCenters = [];

  for (RecyclingCenter center in recyclingCenters) {
    double distance =
        calculateDistance(userLat, userLon, center.latitude, center.longitude);
    if (distance <= radius) {
      nearbyCenters.add(RecyclingCenter(
          center.name, center.latitude, center.longitude,
          distance: distance));
    }
  }

  // Sort by distance
  nearbyCenters.sort((a, b) => a.distance.compareTo(b.distance));

  return nearbyCenters;
}

double calculateDistance(double startLatitude, double startLongitude,
    double endLatitude, double endLongitude) {
  const double R = 6371.0; // Radius of the Earth in kilometers
  double dLat = degreesToRadians(endLatitude - startLatitude);
  double dLon = degreesToRadians(endLongitude - startLongitude);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(degreesToRadians(startLatitude)) *
          cos(degreesToRadians(endLatitude)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

class SustainableProduct {
  final String name;
  final String description;
  final String imageUrl;
  final String link;

  SustainableProduct({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.link,
  });
}

class SustainableProductRecommendationsPage extends StatelessWidget {
  final List<SustainableProduct> products = [
    SustainableProduct(
      name: "Reusable Stainless Steel Straws",
      description: "Durable and eco-friendly alternative to plastic straws.",
      imageUrl: "https://m.media-amazon.com/images/I/61YKvbNqFdL.jpg",
      link:
          "https://www.amazon.in/dp/B083DYQ4SK/?_encoding=UTF8&pd_rd_i=B083DYQ4SK&ref_=sxts_sparkle_sbv&qid=1716492215&pd_rd_w=mowIS&content-id=amzn1.sym.df9fe057-524b-4172-ac34-9a1b3c4e647d%3Aamzn1.sym.df9fe057-524b-4172-ac34-9a1b3c4e647d&pf_rd_p=df9fe057-524b-4172-ac34-9a1b3c4e647d&pf_rd_r=1QVG6XW35F7NFKAN11B2&pd_rd_wg=iJJ9d&pd_rd_r=1daea4cf-bf20-404f-bbb6-c17adee2b8c4&pd_rd_plhdr=t&th=1",
    ),
    SustainableProduct(
      name: "Bamboo Toothbrushes",
      description: "Biodegradable toothbrushes made from sustainable bamboo.",
      imageUrl:
          "https://imgs.search.brave.com/4-RqeTVGUZCNc_K2d3FgV7HbkUGfdRusaMF_us4UnKY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzVkL2Uw/LzlhLzVkZTA5YWRl/YzkzZGE0OTdkMDM5/NjdkNWViMjhiMzkx/LmpwZw",
      link:
          "https://www.amazon.in/Eco-Friendly-Toothbrush-Charcoal-Activated-Bristles/dp/B0CNRKPK2N/ref=sr_1_9?sr=8-9",
    ),
    SustainableProduct(
      name: "Eco-Friendly Reusable Water Bottles",
      description:
          "BPA-free and reusable water bottles to reduce plastic waste.",
      imageUrl: "https://m.media-amazon.com/images/I/81xRxMhp06L._SX679_.jpg",
      link:
          "https://www.amazon.in/WQT-Handmade-Earthen-Water-Bottle/dp/B0B754HN7S/ref=sr_1_3_sspa?sr=8-3-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1",
    ),
    SustainableProduct(
      name: "Organic Cotton Tote Bags",
      description:
          "Stylish and eco-friendly tote bags made from organic cotton.",
      imageUrl: "https://m.media-amazon.com/images/I/71DhkTvbxlL._SY741_.jpg",
      link:
          "https://www.amazon.in/Harry-Kritz-Vertical-Stylish-Organic/dp/B0BNJKK8BZ/ref=sr_1_8?sr=8-8",
    ),
    SustainableProduct(
      name: "Solar-Powered Outdoor Lights",
      description: "Illuminate your outdoor space with solar-powered lights.",
      imageUrl: "https://m.media-amazon.com/images/I/51elV7st5QL._SX679_.jpg",
      link:
          "https://www.amazon.in/AP-ZP-Exteriores-Landscape-Waterproof/dp/B0CV4V9B4S/ref=sr_1_9?sr=8-9",
    ),
    SustainableProduct(
      name: "Recycled Paper Notebooks",
      description: "Eco-friendly notebooks made from recycled paper.",
      imageUrl: "https://m.media-amazon.com/images/I/41BaTXELmvL.jpg",
      link:
          "https://www.amazon.in/HELLOPERFECT-Recycled-Paper-Notebook-Practice/dp/B07MGM57LQ",
    ),
    SustainableProduct(
      name: "Biodegradable Bamboo Cutlery Set",
      description: "Eco-friendly cutlery set made from sustainable bamboo.",
      imageUrl: "https://m.media-amazon.com/images/I/81HtBsFLUjL._SX522_.jpg",
      link:
          "https://www.amazon.in/Disposable-Wooden-Cutlery-Set-Biodegradable/dp/B07TDQTGFP/ref=sr_1_4?sr=8-4",
    ),
    SustainableProduct(
      name: "Reusable Beeswax Food Wraps",
      description:
          "Alternative to plastic wrap made from organic cotton and beeswax.",
      imageUrl:
          "https://m.media-amazon.com/images/I/714A0-PwbJL._SX679_PIbundle-3,TopRight,0,0_AA679SH20_.jpg",
      link:
          "https://www.amazon.in/Urban-Creative-Certified-Organic-Assorted/dp/B07MFW3KJS/ref=sr_1_5?sr=8-5",
    ),
    SustainableProduct(
      name: "Bamboo Utensil Set",
      description: "Eco-friendly utensil set made from renewable bamboo.",
      imageUrl: "https://m.media-amazon.com/images/I/61nCQO8jvWL._SX679_.jpg",
      link:
          "https://www.amazon.in/ECO-SOUL-Utensils-Non-Stick-Certified/dp/B0BN87GM7V/ref=sr_1_1_sspa?sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1",
    ),
    SustainableProduct(
      name: "Compostable Trash Bags",
      description: "Biodegradable trash bags made from plant-based materials.",
      imageUrl:
          "https://m.media-amazon.com/images/I/61epI8ItZeL._SY450_PIbundle-3,TopRight,0,0_AA450SH20_.jpg",
      link:
          "https://www.amazon.in/Amazon-Brand-Presto-Compostable-Garbage/dp/B0CWV1CZZJ/ref=sr_1_1_sspa?sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1",
    ),
    // Add more sustainable products here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text('Sustainable Product Recommendations',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                // Open Amazon link for the product
                launch(products[index].link);
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(products[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              products[index].description,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Buy now on Amazon',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TotalPointsPage extends StatelessWidget {
  final int totalPoints;

  TotalPointsPage({required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Points'),
      ),
      body: Center(
        child: Text(
          'Your total points: $totalPoints',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
