class Encryptor
  def cipher
    { 'a' => 'n', 'b' => 'o', 'c' => 'p', 'd' => 'q', 
      'e' => 'r', 'f' => 's', 'g' => 't', 'h' => 'u',
      'i' => 'v', 'j' => 'w', 'k' => 'x', 'l' => 'y',
      'm' => 'z', 'n' => 'a', 'o' => 'b', 'p' => 'c',
      'q' => 'd', 'r' => 'e', 's' => 'f', 't' => 'g',
      'u' => 'h', 'v' => 'i', 'w' => 'j', 'x' => 'k',
      'y' => 'l', 'z' => 'm'}
  end
  
  def encrypt_letter(letter)
    lowercase_letter = letter.downcase
    cipher[lowercase_letter]
  end
  
  def encrypt(string)
    # Cut the input string into letters
    letters = string.split("")
    
    # Encrypt those letters one at a time, gathering the results
    # After reseraching about .collect and .map method, I decided to use .map method instead of 
    # .collect method in the tutorial, as "The map function has many naming conventions in different       languages"
    results = letters.map do |letter|
      encrypt_letter(letter)
    end
    
    # Join the results back together in one string
    results.join
  end
end