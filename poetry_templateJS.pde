
import java.util.*;

ArrayList<Word> words = new ArrayList<Word>();
PFont font = createFont("Arial", 16);
PFont font2 = createFont("times", 16);
/*
ADJ:quick,brown,agile
NOUN:fox,dog,person
VERB:jump,bark
*/


void setup() {
  size(500,500);  

  Map<String, ArrayList<String>> wordMap = loadInWords("words.txt");
 //println(file); 

 /* 
  for (String k : wordMap.keySet()) {
    println("key = " + k); 
  
    List<String> values = wordMap.get(k);
  
    for (String v : values) {
      println("\tvalue = " + v);
    }   
  }
  */
  
  words = parseGrammar(wordMap, "grammar.txt"); 
}


/*** 
  Loads in a text file indicating words assoicated with parts of speech, parses it, 
  and returns a Map of each part of speech and its assoicated List of words.
  Assumes each line looks like:

    POS:word1,word2,...,wordN
***/  
Map<String, ArrayList<String>> loadInWords(String filename) {
  
  Map<String, ArrayList<String>> m = new HashMap<String, ArrayList<String>>();
  
  String[] lines = loadStrings(filename);
  
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
    String[] chop = split(lines[i], ':');
    
    String POS = chop[0];
    String wordsStr = chop[1];
    println("\tLEFT SIDE = " + POS);
    println("\tRIGHT SIDE = " + wordsStr + "\n");
    
    String[] wordsArr = split(wordsStr, ','); //split right side into an array of Strings
    println(wordsArr);
    
    ArrayList<String> wordsList = new ArrayList<String>();
    for(int j = 0; j < wordsArr.length; j++){
      println(wordsArr[j]);
      wordsList.add(wordsArr[j]);
    }
    // = Arrays.asList(wordsArr); //turns array into a List
    
    
   
    for (String tmpStr : wordsList) {
      println("\t\tword="+tmpStr);
    }
    
    
    m.put(POS, wordsList);
  }
  
  return m;
}


/***
  Reads through a text file of parts of speech and looks through a Map m for a random word 
  that corresponds to each part of speech. Returns a populated List of Word objects, where
  each type of Word has its own render() method.
***/



ArrayList<Word> parseGrammar( Map<String, ArrayList<String>> m, String filename) {
  
  ArrayList<Word> ws = new ArrayList<Word>();
  // TO DO - 
  // 1. Load in Strings from "grammar.txt" and loop through each line.
  String[] lines = loadStrings(filename);
  
  
  for(String line : lines) {
    //println(line); 
    
    String[] posArr = line.split(" ");
    ArrayList<String> posList = new ArrayList<String>();
    for(int i = 0; i < posArr.length; i++){
      println("watch for me" + posArr[i]);
      posList.add(posArr[i]);
    }
   // List<String> posList = Arrays.asList(posArr); //turns array into a List
    
    for (String p : posList) {
      println("\t" + p);
      
      ArrayList<String> listOfWords = new ArrayList<String>();
      listOfWords = m.get(p);
      
      int randNum = (int) random(0,listOfWords.size());
       
      String randomWord = listOfWords.get( randNum );
      println("\t\t" + randomWord);
      
      Word w;
      if (p.equals("NOUN")) {
        w = new WordNoun(randomWord, p);
       // println(w.word);
      } else {
        w = new Word(randomWord, p);
       // println(w.word);
      }
      
      ws.add(w);
      
    }
  }
  
  
  // 2. For each POS in the line, get the associated List of words from Map m.
  // 3. Choose a random word from the list.
  // 4. Place this word in a List that we will read from in the draw() loop. 
  
  return ws;
 }




void draw() {
   background(255,0,0,255); 
   
   int pX = 10;
   int pY = 50;
   
   for (Word w : words) {
     w.render(pX, pY);
     
     int sw = (int)textWidth(w.word);
     pX += sw + 10;
     
     if (pX > width) {
       pX = 10;
       pY += 50;
     }
   } 
}
  
