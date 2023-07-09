import sys.io.File;

class DylibCompiler {
  
  public static function compileDylibs(folderPath:String):Array<String> {
    var dylibs:Array<String> = [];
    
    // Get the list of files in the folder
    var files:Array<String> = File.listDir(folderPath);
    
    // Iterate through each file
    for (file in files) {
      // Check if the file has a .dylib extension
      if (file.toLowerCase().endsWith(".dylib")) {
        var filePath:String = folderPath + "/" + file;
        
        // Compile the dylib using the haxe command
        var command:String = "haxe --cpp dylib \"" + filePath + "\"";
        var output:String = Sys.commandOutput(command);
        
        // Check if the compilation was successful
        if (output.indexOf("Compilation succeeded") != -1) {
          dylibs.push(filePath);
        } else {
          trace("Failed to compile dylib: " + filePath);
        }
      }
    }
    
    return dylibs;
  }
  
}

class Main {
  
  static function main() {
    var folderPath:String = "/path/to/dylibs";
    var dylibs:Array<String> = DylibCompiler.compileDylibs(folderPath);
    
    // Do something with the compiled dylibs
    for (dylib in dylibs) {
      trace("Compiled dylib: " + dylib);
    }
  }
  
}
