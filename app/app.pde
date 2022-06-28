import java.util.Map;

//========================================
final color black      = #000000;
final color white      = #FFFFFF;
final color red        = #FF0000;
final color pink       = #FF6ABC;
final color lightBlue  = #00FCEE;
final color brown      = #9F642C;
final color blue       = #324BE3;
final color gray       = #818183;
final color lightGreen = #00FF00;
final color cyan       = #94BBC1;
final color yellow     = #F6FF05;
final color orange     = #FF7E05;
final color lightCyan  = #E8F9FC;  
final color lightGray  = #BDCBCE;
final color silver     = #D1D1D1;
final color gold       = #E5C982;
//images/fonts ===========================
PShape target, plus, pencil, home, eraser;
PFont andalemoFont, rubikFont, ubuntuFont, ubuntuBoldFont, ubuntuMonoFont;

// Mode framework ========================
enum Mode { MAIN, INPUT, OUTPUT, NEW };
Mode mode;

// Maps chosen subject to test data
Map<String, ArrayList<Test>> data;
int subjectIdx;

//all the buttons :(
Button inputB, outputB, homeB, subjectB; //toolBar
Button saveButton, clearButton, addSubjectButton;

// keypress variables
int curKey = -1, curKeyCode = -1; // -1 = no key pressed
boolean isKeyHeld = false;

// textboxes
TextBox inputStudyTime, inputMark, inputTarget, inputSubject;

void setup() {
  frameRate(60);
  size(1200, 800);
  textAlign(CORNER, CENTER);
  
  //load images / font   ==================
  plus = loadShape("data/images/plus.svg");
  target = loadShape("data/images/target.svg");
  pencil = loadShape("data/images/pencil.svg");
  home = loadShape("data/images/home.svg");
  eraser = loadShape("data/images/eraser.svg"); //https://www.onlinewebfonts.com/icon/468470
  
  rubikFont = createFont("data/fonts/rubik.ttf", 1);
  andalemoFont = createFont("data/fonts/andalemo.ttf", 1);
  ubuntuFont = createFont("data/fonts/ubuntu.ttf", 1);
  ubuntuBoldFont = createFont("data/fonts/ubuntu_bold.ttf", 1);
  ubuntuMonoFont = createFont("data/fonts/ubuntu_monobold.ttf", 30);
  
  //intialize the textboxes
  inputStudyTime = new TextBox(100, 350, 500, 50, ubuntuMonoFont);
  inputMark = new TextBox(100, 500, 500, 50, ubuntuMonoFont);
  inputTarget = new TextBox(100,350,500,50,ubuntuMonoFont);
  inputSubject = new TextBox(100, 350, 500, 50, ubuntuMonoFont);

  //=======================================
  loadData();
  
  // add arbitrary values (for testing purposes)
  ArrayList<Test> bio = new ArrayList<Test>();
  bio.add(new Test(80, 90));
  bio.add(new Test(65, 80));
  bio.add(new Test(50, 65));
  ArrayList<Test> math = new ArrayList<Test>();
  math.add(new Test(90, 100));
  math.add(new Test(70, 80));
  ArrayList<Test> eng = new ArrayList<Test>();
  eng.add(new Test(50, 1));
  eng.add(new Test(50, 2));
  eng.add(new Test(60, 3));
  data.put("Biology", bio);
  data.put("Math", math);
  data.put("English", eng);
  
  // *FOR DEBUGGING*
  dumpData();
  
  // start on the main screen
  mode = Mode.MAIN;
  
  //initalize buttons for all modes
  initalizeButtons();
  
  // set subject to first one in map
  subjectIdx = 0;
}

void draw() {
  background(255);
  
  switch (mode) {
  case MAIN: mainMode(); break;
  case INPUT: inputMode(); break;
  case OUTPUT: outputMode(); break;
  case NEW: newMode(); break; //this is the draw function of Mode.NEW, don't think otherwise
  }
 
  toolBar();
  
}

void mouseClicked() {
  toolBarClick();
  
  if (mode == Mode.MAIN) mainClick(); 
  else if (mode == Mode.INPUT) inputClick(); 
  else if (mode == Mode.OUTPUT) outputClick(); 
  else if (mode == Mode.NEW) newClick(); 
}

//========================================================================

final int toolbarW = 200;

void toolBar() {
  //render the tool bar ============
    fill(blue);
    noStroke();
    rect(width-toolbarW, 0, toolbarW, height);
    
    //render the buttons
    inputB.render();
    outputB.render();
    homeB.render();
    subjectB.render();
}

void toolBarClick() {
  if (inputB.isHover()) mode = Mode.INPUT;
  else if (outputB.isHover()) mode = Mode.OUTPUT;
  else if (homeB.isHover()) mode = Mode.MAIN;
  else if (subjectB.isHover()) mode = Mode.NEW;    
}

void initalizeButtons() {
  //used for initalizing the buttons, the rendering occurs in their respective modes
  //mode - MAIN
  
  
  saveButton = new Button("Save", 100, 600, 200, 50, white, black, 30, plus); 
  clearButton = new Button("Clear", 350, 600, 200, 50, white, black, 30, eraser);
  addSubjectButton = new Button("Add", 100, 450, 200, 50, white, black, 30, plus);
  
  inputB = new Button("Input new test information", width-210,30,200,50,lightGray,white,20,pencil);
  outputB = new Button("Set a Target", width-210,90,200,50,lightGray,white,20, target);
  homeB = new Button("Homepage", width-210,150,200,50,lightGray,white,20, home);
  subjectB = new Button("New Subject", width-210, height-100, 200, 50, lightCyan, blue, 20, plus);
  
  //mode - INPUT
  
  //mode - OUTPUT
  
  //mode - GRAPH
  
  //mode - NEW
  
}
