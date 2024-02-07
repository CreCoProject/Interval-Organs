// Declare global Variable for Song
Song sng;
// Declare max and min lenght of the Melodies
int mml, iml;


// Setup of the Script
void setup()
{
  // Create a Canvas Landscaped 500 * 300 Pixels
  size(500, 300);
  // Set Color Mode to RGB and Range to 100
  colorMode(RGB, 100);
  
  // Initialise a new Song
  sng = new Song();
  
  // Intialise Max 6 and Min 1 Size of Melody
  iml = 1;
  mml = 6;
  
  // Prsent the Welcoming Menue
  menue();
};

// The Welcoming Menue
void menue(){
  println(" Welcome to the Song Grapher");
  println(" ---------------------------");
  println(" This little Program makes a Color Song ");
  println();
  println(" With Key n you can draw a new Melody");
  println(" With Key m you can new drew the actual Song");
  println(" With Key o you can geneate a new Melody in the Song");
  println(" With Key p you can delte a random Melody from Song");
  println(" With Key q you can increase the maximal Amount of Events in a Melody");
  println(" With Key q you can decrease the maximal Amount of Events in a Melody");
  println(" With Key a you can increase the minimal Amount of Events in a Melody");
  println(" With Key s you can decrease the minimal Amount of Events in a Melody");
  println(" With Key y you can save the actual Song Graphik");
}

// Dummy draw Method for enabling KeyPressed Control System
void draw(){}

// Class for the Model of Colors in this Script
class ColorModel{
  // Declaration of the Color Variable in this Model
  color c;
  
  // Delta Version for Color Transformation in the Model
  int delRed; // Delta Value for Red
  int delGreen; // Delta Value for Green
  int delBlue; // Delta Value for Blue
  
  // Constructor for the Model of Color
  ColorModel(){
    // Define a random Color for the main Color
    c = color(random(100), random(100), random(100));
    
    // Define the Delta Values for the Color Transformation
    delRed = int(random(100)); // Defines the Red Amount in the Transformation
    delGreen = int(random(100)); // Defines the Green Amount in the Transformation
    delBlue = int(random(100)); // Defines the Blue Amount in the Transformation
    
  }
  
  // Color Transformation Method
  color getUpdate(){
    // Choose the Central Ampunt of Transformation
    int m = int(random(6));

    // Redas the Attributes from the central Color
    float red = red(c); // Reads Red Value
    float green = green(c); // Reads Green Value
    float blue = blue(c); // Reads Blue Value 
    
    // Caöculate the Color Transformation
    // Add Delta Values multiple with Centrsl Amount and Map on Color Range
    red = (red + (delRed*m))%100; // Calculate for Red Channel
    green = (green + (delGreen*m))%100; // Calculate for Green Channel
    blue = (blue + (delBlue*m))%100; // Calculate for Blue Channel 
    
    // Recreate the Color and return it from Method
    return color(red, green, blue);
  }
  
  // Method for Mixing Colors as Offset by addition
  // Needs the Color to mix in
  color offset(ColorModel cm)
  {
    // Read Color in from Color Model of addited Color
    color ci = cm.getColor();
    // Mixing the Colors by addition and Map back to the Color Range  
    color cv =  color((red(ci)+red(c))%100, (green(ci)+green(c))%100, (blue(ci)+blue(c))%100);
    // Return new Color
    return cv;
  }
  
  // Geter from Model of Color of Color
  color getColor(){
    return c;
  }
  
  // Seter Method of Color to Model of Color
  // Needs the to seting Color
  void setColor(color cc){
    c = cc;
  }
}

// Class for Events in Melody
class Event{
  // Declare Variable for Model of Color for the Event
  ColorModel cm;
  // Declare Variable for Wide of the Event in the Melody
  float wide;
  
  // Constructor for the Event in Melody
  // Needs the Color from the Melody
  Event(ColorModel cn ){
    // Initalise the Model of Color for the Event
    cm = new ColorModel();
    // Derivate the resulting Color from own Color and Color of Melody 
    cm.setColor(cn.getUpdate());
    // Choose a wide for the Event
    wide = random(1);
  }
  
  // Method to draw the Event
  // 
  void drawing(int x, float total, float wideo, ColorModel cn)
  {
    // Sets Mixed Color to drawing Color
    fill(cn.offset(cm));
    // draws the Rectangle for the Event
    // Calculate true Width of Rectangle from Ampunt of Wide in the Event
    //   And total Space in Melody
    rect(x, 0, wide/total*wideo, height);
  }
  
  // Getter Method for true Size of Element in Melody
  int size(float total, float wideo)
  {
    return int(wide/total*wideo);
  }
  
  // Getter Method for Color
  color getColor()
  {
    return cm.c;
  }
  // Getter Method for wide of Event  
  float getWide()
  {
    return wide;
  }
}

// Class for the Melody
class Melody{
    // Declarate Collection Variable for Events in Melody
    ArrayList<Event> events = new ArrayList<Event>();
    // Counter Variable for complete wide of Melody
    float sumWide;
    
    // Melody Constructor
    Melody(){
      // Initalise Variable for complete Wide of Melody to zero
      sumWide = 0;
      
      // Initalise a Model of Color for the Melody
      ColorModel cm = new ColorModel();
      
      // Choose a lenght of Events for the Melody
      int n = int(random(mml - iml)+iml);
      // Iterrates about all Events in Melody
      for( int x = 0; x < n; x++)
      {
        // Intialise actual Events and collet to Collction Variable
        events.add(new Event(cm));
      }
      // Iterates about all Events in Melody
      for (Event even : events) {
        // Sum up the Wide of actual Event to complete lenght of Melody
        sumWide += even.getWide();
      }
    }
    
    // Method to draw the complete Melody
    void drawMelody(int x, ColorModel cn, int wide)
    {
      // Iterrates about all Events in Melody
      for (Event even : events) {
        // Call the Method to draw actual Event
        even.drawing(x, sumWide, wide, cn);
        // Sum up Position in the Melody
        x += even.size(sumWide, wide);
      }
    } 
}

// Method to handle lenghts
class lenght{
  // Declare Variable for lenght
  float n;
  
  // Setter Method for lenght
  lenght(float m){
    n = m;
  }
  
  // Getter Method for lenght
  float getLenght(){
    return n;
  }
}

// Class to handle complete Song
class Song{
      // Declare Collector Variabl for Melody Patterns
      ArrayList<Melody> paterns = new ArrayList<Melody>();
      // Declare Collcetor Variable for playing Lenghts for Melody 
      ArrayList<lenght> lenghts = new ArrayList<lenght>();
      
      // Constructor for Song
      Song(){
        // Choose a number of Melodys in the Song
        int n = int(random(6))+1;
        // Iterrates about needed number of Melodys
        for( int x = 0; x < n; x++)
        {
          // Create needed Melody and add them to the Song
          paterns.add(new Melody());
        }
      }
       // Method to add a new Melody
      void newMelody(){
        // Initalise new Melody and add them to Patern Register
        paterns.add(new Melody());
      }
      
      void delMelody(){
        if(paterns.size() > 0){
          int n = int(random(paterns.size()));
          paterns.remove(n);
        }
      }
      
      // Methhod to play the Song
      void playSong(){
        // Declare Variable for Choosen Melody
        int m;
        // Declare Variable for Choosen Rhythmic Status
        int cas;
        // Declare Variale for Models of Color for Song and Melody
        ColorModel col, colj;
        // Declare Variable for Position in Song
        float hasLenght = 0;
        // Declare and Initialise Duration to 1
        float dur = 1;
        // Declare and Initialise realativ Song Lenght to zero 
        float sumLenght = 0;
        
        // Choose a lenght of Song in Melodys
        int n = int(random(6)+1);
        
        // Iterate about Melody Positions in Song
        for( int q = 0; q < n; q++)
        {
          // Choose a Rhythmical Status
          cas = int(random(5));
          // Switch about Rhythmical Status
          switch(cas){
            // Half Rhythmical Time
            case 0: dur = dur / 2; break;
            // Tripple Rhyhmical Time
            case 1: dur = dur /3; break;
            // lets Rhythmical Time Unchanged
            case 2: break;
            // double Rhythmical Time
            case 3: dur = dur * 2; break;
            // make Rhythmical Time three times larger
            case 4: dur = dur * 3; break;
          }
          // Add Rhythmical Time to Lenghts Colection
          lenghts.add(new lenght(dur));
          // Sum Up Rhythmmical Time to Song Lenght
          sumLenght += dur;
         }
        
        // Clesr Canvas to white
        background(100);
        
        // Intialise Color Model for Song
        col = new ColorModel();
        
        if( paterns.size() > 0)
        {
          // Iterate about Number of Melody Position in Song
          for( int x = 0; x < n; x++)
          {
            // Choose a Random Melody for the Song Position
            m = int(random(paterns.size()));
            // Intialise Model of Color for Position in Song 
            colj = new ColorModel();
            // Derivate Model of Color from Song Model of Color
            colj.setColor(col.getUpdate());
            // Draws choose Song 
            //    with physical Position in Song, Model of Color for actual Position
            //    and Calculated wide for Melody derivated from realativ Song Lenght
            //      and Rhythmical Time
            paterns.get(m).drawMelody(int(hasLenght), colj, int((float(width)/sumLenght)*lenghts.get(x).getLenght()));
            // Calculate new physicl starting Position for next Melody
            //   from realative Song Lenght and Rhythmical Time
            hasLenght = hasLenght + (float(width)/sumLenght)*lenghts.get(x).getLenght();
          }
        }
      }
      
      
}

// Function to generate a new Song from Menue
void generateNewSong(){
  // Generate new Song
  sng = new Song();
  // Play this new Song
  sng.playSong();
}

// Play the new Song in Variation
void playSong()
{
  sng.playSong();
}

// Add a new Melody
void addNewMelody(){
  sng.newMelody();
}

// Remove a random Melody
void removeMelody(){
  sng.delMelody();
}

void expandMML()
{
  mml++;
  println("New Maximal Melody Lenht is: " + mml); 
}

void minimkizeMML()
{
  if( mml > 0)
  {
    mml--;
    println("New Maximal Melody Lenht is: " + mml); 
  }
}

void expandIML()
{
  if( iml < mml)
  {
    iml++;
    println("New minimal Melody Lenht is: " + iml);
  }
}

void minimizeIML()
{
  if(iml>0)
  {
    iml--;
    println("New mnimal Melody Lenht is: " + iml);
  }
}

// Menue listener 
void keyPressed()
{
  println("Test");
  // Switch to called Menue Point
  switch(key){
    case 'n': generateNewSong(); break;
    case 'm': playSong(); break;
    case 'o': addNewMelody(); break;
    case 'p': removeMelody(); break;
    case 'q': expandMML(); break;
    case 'w': minimkizeMML(); break;
    case 'a': expandIML(); break;
    case 's': minimizeIML(); break;
    case 'y': save("SongGrapher.png"); break;
    
  }
}
