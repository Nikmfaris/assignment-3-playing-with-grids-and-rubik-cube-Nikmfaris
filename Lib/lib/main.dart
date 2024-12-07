import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.green, Colors.green, Colors.green, Colors.green], // Left
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Right
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // rear
    [Colors.white, Colors.white, Colors.white, Colors.white], // Top
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Bottom
  ];

  // Rotate top face to the left, modify if necessary
  void rotateTop() {
    // Store the top row of each face
    List<Color> topRowFront = [faces[0][0], faces[0][1]];
    List<Color> topRowLeft = [faces[1][0], faces[1][1]];
    List<Color> topRowRight = [faces[2][0], faces[2][1]];
    List<Color> topRowBack = [faces[3][0], faces[3][1]];

    // Rotate top face
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[3], tempTop[0], tempTop[1]];

    // Update adjacent faces
    faces[0] = [faces[3][2], faces[3][3], ...faces[0].sublist(2)];
    faces[1] = [faces[0][2], faces[0][3], ...faces[1].sublist(2)];
    faces[2] = [faces[1][2], faces[1][3], ...faces[2].sublist(2)];
    faces[3] = [faces[2][2], faces[2][3], ...faces[3].sublist(2)];
  }

  // Rotate bottom face to the left, modify if necessary
  void rotateBottom() {
    // Implement your code here
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void rotateTop() {
    setState(() {
      cube.rotateTop();
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_left),
            onPressed: rotateTop,
          )
        ],
      ),
      body: Container(
        color: const Color(0xFF1B1B1B), // background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top face
              Column(
                children: [
                  const Text('Top', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[4]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left face
                  Column(
                    children: [
                      const Text('Left', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: buildFace(cube.faces[1]),
                      ),
                    ],
                  ),
                  // Front face
                  Column(
                    children: [
                      const Text('Front',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: buildFace(cube.faces[0]),
                      ),
                    ],
                  ),
                  // Right face
                  Column(
                    children: [
                      const Text('Right',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: buildFace(cube.faces[2]),
                      ),
                    ],
                  ),
                ],
              ),
              // Bottom face
              Column(
                children: [
                  const Text('Bottom', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[5]),
                  ),
                ],
              ),
              // Rear face
              Column(
                children: [
                  const Text('Back', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[3]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
