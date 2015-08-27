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
  
  def encrypt_file(filename, rotation)
    # Create the file handle to the input file
    # Use the filename variable from the parameter with the File.open call. Remember to specify the       right read/write mode.
    inputfile = File.open(filename, "r")
      
    # Read the text of the input file. Just call the same method you did before to read the content       s. You’ll need to save this into a variable. Don't close the read_file yet since we need to en       crypt it
    read_file = inputfile.read
    
    # Encrypt the text. Call your .encrypt method passing in the text from step 2 and the rotation p        arameter
    encrypted_text = encrypt(read_file, rotation)
    
    # Create a name for the output file. Name the output file the same as the input file, but with         ".encrypted" on the end. So an input file named "sample.txt" would generate a file named "samp       le.txt.encrypted". Store the name in a variable.
    encrypted_file = filename + ".encrypted"
    
    # Create an output file handle. Create a new file handle with the name from step 4 and remember       the correct read/write mode.
    outputfile = File.open(encrypted_file, "w")
    
    # Write out the text. Use the .write method like before.
    outputfile.write(encrypted_text)
    
    # Close the file. Call .close on the output file handle
    outputfile.close
  end
  
  def decrypt_file(encryptfilename, rotation)
    inputfile = File.open(encryptfilename, "r")
    read_file = inputfile.read
    decrypted_text = decrypt(read_file, rotation)
    decrypted_file = encryptfilename.gsub("encrypted", "decrypted")
    outputfile = File.open(decrypted_file, "w")
    outputfile.write(decrypted_text)
    outputfile.close
  end
  
  def supported_characters
    (' '..'z').to_a
  end
  
  def crack(message)
    supported_characters.size.times.map do |attempt|
      decrypt(message, attempt)
    end
  end
end