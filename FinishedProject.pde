import qrcodeprocessing.*;       // Library from Daniel Shiffman "QRCode"
import processing.video.*;        // Library from The Processing Foundation "Video"


                               // Create and initialize decoder object
Decoder decoder;              // Instructions using library from shiffman.net 
                 
                            
//PImage qrcode;
Capture video;                          
String statusMsg = "";                     // Empty string for output

void setup() 
{
  size (800,700);                                               
  video = new Capture(this, 640 , 480);                  // Video resolution 480p 640x480 pixels
  video.start();                                         // Begin video
  //qrcode = loadImage("qrcode.png");
  
  decoder = new Decoder(this);                        // Declare decoder object,  from Daniel Shiffman @ https://shiffman.net/p5/qrcode-processing/
}



void captureEvent(Capture video)                 // Allows every new event/frame captured by cam to be read
{
  video.read();           
}


void decoderEvent(Decoder decoder)                     // Method begins when object is finished decoding
{
  statusMsg = decoder.getDecodedString();
  println(statusMsg);
}


void draw()
{
  background(46,184,255);
  
  /*fill(0);
  rect(130,330,130,30);
  textSize(25);
  fill(255,255,255);
  text("Scan Me",148,355);
  pushStyle();
  fill(255,255,255);                                         // For QR Code upload png 
  noStroke();
  rect(269,62,40,10);
  rect(300,62,10,40);
  rect(83,289,40,10);
  rect(80,259,10,40);
  popStyle();*/ 
  // PImage img = loadImage("qrcode.png");
  //decoder.decodeImage(img);
  //image(qrcode, 98,80,196,201);
  
  image(video,90,50);                                         // Create video image so it is visible on screen
  
  fill(255,255,255);
  rect(303,553,190,50);                                       // Scan Now box to begin decoding QRCode                                     
  textSize(35);
  fill(0);
  text("Scan Now",318,592);
  
  fill(255,255,255);
  strokeWeight(2);
  rect(495,156,40,10);
  rect(535,156,10,40);
  
  rect(265,445,40,10);
  rect(265,415,10,40);                                                  // QR code layout dimensions
  
  rect(265,156,40,10);
  rect(265,156,10,40);
  
  rect(495,445,40,10);
  rect(535,415,10,40);
}



void mousePressed()                                            // Interactive button 
{
  //println(mouseX,mouseY);                                      // Used to calculate dimensions of 'mousepressed' area & placing images
  if (mousePressed)
  {
    if (mouseX>302 && mouseX <494 && mouseY>553 && mouseY <605)
    {
      PImage savedFrame = createImage(video.width, video.height, RGB);          // Create image of whole area of video
      savedFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); 
      savedFrame.updatePixels();                                 // Apply updates to display window after copy
      decoder.decodeImage(savedFrame);                          // Decode video saved in 'savedFrame'
      println(statusMsg);                                     // Return decoded result from DecoderEvent and enter into console
    }
  }
}
