class Gossip
  attr_accessor :author, :content, :comments
  

  def initialize(author, content, comments)
    @author = author
    @content = content
    @comments = comments  
  end 

  def save
    all_comments = []
    CSV.open("./db/gossip.csv", "ab") do |csv|
    csv << [@author, @content, @comments]
    end

  end


  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
    end
    return all_gossips
  end


  def edit(id)
    rows_array = CSV.read("./db/gossip.csv")
    rows_array[id][1] = @content
    
    CSV.open("./db/gossip.csv", "wb") do |csv|
    rows_array.each {|row| csv << row }
    end 
  end

  def edit_comments(id, comment)
    rows_array = CSV.read("./db/gossip.csv")
    
    puts "comment #{comment}"
    puts "comment class #{comment.class}"
    new_array = rows_array[id][2].split.push(comment)
    puts "new_array #{new_array}"
    rows_array[id][2] = new_array
    
    CSV.open("./db/gossip.csv", "wb") do |csv|
    rows_array.each {|row| csv << row }
    end 
  end
  
  

end 