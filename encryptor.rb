class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end
  
  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end
  
  def encrypt(string, rotation)
    # Cut the input string into letters
    letters = string.split("")
    
    # Encrypt those letters one at a time, gathering the results
    # After reseraching about .collect and .map method, I decided to use .map method instead of 
    # .collect method in the tutorial, as "The map function has many naming conventions in different       languages"
    results = letters.map do |letter|
      encrypt_letter(letter, rotation)
    end
    
    # Join the results back together in one string
    results.join
  end
  
  def decrypt_letter(letter, rotation)
    cipher_for_backrotation = cipher(rotation*(-1))
    cipher_for_backrotation[letter]
  end
  
  def decrypt(string, rotation)
    # Cut the input string into letters
    letters = string.split("")
    
    # Encrypt those letters one at a time, gathering the results
    # After reseraching about .collect and .map method, I decided to use .map method instead of 
    # .collect method in the tutorial, as "The map function has many naming conventions in different       languages"
    results = letters.map do |letter|
      encrypt_letter(letter, rotation*(-1))
    end
    
    # Join the results back together in one string
    results.join
  end
end