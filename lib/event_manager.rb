require "csv"
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  # We make a directory named "output" if a directory named "output" does not already exist
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  # File#open allows us to open a file for reading and writing
  # The first parameter is the name of the file. The second parameter is a flag that states how we want to open the file.
  # The ‘w’ states we want to open the file for writing. If the file already exists it will be destroyed.
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end 

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |column|
  id = column[0]
  name = column[:first_name]
  zipcode = clean_zipcode(column[:zipcode])
  
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end

# After running the program, it will generate the output files for each even atendee.

