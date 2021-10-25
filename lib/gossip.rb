class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end 

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
    csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def edit(id)
    puts "edit author #{@author}"
    puts "edit content #{@content}"

    puts "ça passe"
    rows_array = CSV.read("./db/gossip.csv")
    rows_array[id][1] = @content

    puts "rows_array #{rows_array}"
    
    CSV.open("./db/gossip.csv", "wb") do |csv|
    rows_array.each {|row|
      csv << row
    }
    end 
  end

end 