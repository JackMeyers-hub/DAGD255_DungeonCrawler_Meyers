static public class Keyboard {

  // We don't need a constructor in this class because we are NEVER going to instatiate this.

  private static boolean[] keys = new boolean[128];
  private static boolean[] pKeys = new boolean[128];
  public static final int LEFT = 65;
  public static final int RIGHT = 68;
  public static final int UP = 87;
  public static final int DOWN = 83;
  public static final int P = 80;
  public static final int SPACE = 32;
  public static final int Q = 81;

  // This function updates the pKeys array.
  // Sets the boolean values in the pKeys Array to be equal to the values in the keys Array.
  public static void update() {
    for (int i = 0; i < keys.length; i++) {
      pKeys[i] = keys[i];
    }
  }

  // This function updates an element in the keys Array and sets its value to true or false based on a key's state.
  // @param code: keyCode of that key.
  // @param isDown: state of that key.
  // true = isDown
  // false = !isDown
  private static void handleKey(int code, boolean isDown) {
    keys[code] = isDown;                                                                    // bullets.get(i); -> ArrayList
  }                                                                                         // bullets[i]; -> Array

  // Set the state of the key to FALSE;
  // @param code: keyCode of that key.
  public static void handleKeyUp(int code) {
    handleKey(code, false);
  }

  // Set the state of the key to TRUE;
  // @param code: keyCode of that key.
  public static void handleKeyDown(int code) {
    handleKey(code, true);
  }

  // This function lets us know whether a key is held down or not.
  // @param code: keyCode of that key.
  public static boolean isDown(int code) {
    return keys[code];
  }



  // This function lets us know whether a key is pressed on the current frame.
  // @param code: keyCode of that key.
  public static boolean onDown(int code) {
    return (keys[code] && !pKeys[code]);
  }
}
