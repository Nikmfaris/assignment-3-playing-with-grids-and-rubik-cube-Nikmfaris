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

  // Rotate top face to the left
  void rotateTop() {
    // Rotate top face
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[3], tempTop[0], tempTop[1]];

    // Update adjacent faces
    List<Color> temp = [faces[0][0], faces[0][1]];
    faces[0][0] = faces[1][0];
    faces[0][1] = faces[1][1];
    faces[1][0] = faces[3][0];
    faces[1][1] = faces[3][1];
    faces[3][0] = faces[2][0];
    faces[3][1] = faces[2][1];
    faces[2][0] = temp[0];
    faces[2][1] = temp[1];
  }

  // Rotate bottom face to the left
  void rotateBottom() {
    // Rotate bottom face
    List<Color> tempBottom = [...faces[5]];
    faces[5] = [tempBottom[2], tempBottom[3], tempBottom[0], tempBottom[1]];

    // Update adjacent faces
    List<Color> temp = [faces[0][2], faces[0][3]];
    faces[0][2] = faces[2][2];
    faces[0][3] = faces[2][3];
    faces[2][2] = faces[3][2];
    faces[2][3] = faces[3][3];
    faces[3][2] = faces[1][2];
    faces[3][3] = faces[1][3];
    faces[1][2] = temp[0];
    faces[1][3] = temp[1];
  }

  // Rotate left face to the left
  void rotateLeft() {
    // Rotate left face
    List<Color> tempLeft = [...faces[1]];
    faces[1] = [tempLeft[2], tempLeft[3], tempLeft[0], tempLeft[1]];

    // Update adjacent faces
    List<Color> temp = [faces[0][0], faces[0][2]];
    faces[0][0] = faces[4][0];
    faces[0][2] = faces[4][2];
    faces[4][0] = faces[3][3];
    faces[4][2] = faces[3][1];
    faces[3][3] = faces[5][0];
    faces[3][1] = faces[5][2];
    faces[5][0] = temp[0];
    faces[5][2] = temp[1];
  }

  // Rotate right face to the left
  void rotateRight() {
    // Rotate right face
    List<Color> tempRight = [...faces[2]];
    faces[2] = [tempRight[2], tempRight[3], tempRight[0], tempRight[1]];

    // Update adjacent faces
    List<Color> temp = [faces[0][1], faces[0][3]];
    faces[0][1] = faces[5][1];
    faces[0][3] = faces[5][3];
    faces[5][1] = faces[3][2];
    faces[5][3] = faces[3][0];
    faces[3][2] = faces[4][1];
    faces[3][0] = faces[4][3];
    faces[4][1] = temp[0];
    faces[4][3] = temp[1];
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

  void rotateBottom() {
    setState(() {
      cube.rotateBottom();
    });
  }

  void rotateLeft() {
    setState(() {
      cube.rotateLeft();
    });
  }

  void rotateRight() {
    setState(() {
      cube.rotateRight();
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
              // Buttons to rotate the cube
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: rotateLeft,
                    child: const Text('Rotate Left'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: rotateRight,
                    child: const Text('Rotate Right'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: rotateTop,
                    child: const Text('Rotate Top'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: rotateBottom,
                    child: const Text('Rotate Bottom'),
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
