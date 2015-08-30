
class User
  #field :name
  attr_accessor :id, :name

  def maxid
    users = User.all
    max = [ 0, users.map{|h| h[:id]}.max ].max
  end

  def initialize(i = nil, n)
    @id = maxid + 1 unless i
    @name = n
  end

  def User.all
    users = []
    File.open('users.txt', 'r') do |f|
      while userline = f.gets
        id, name = userline.split(',')
	id = id.to_i
        users << {id: id, name: name}
      end
    end
    users
  end

  def User.delete!(target_id)
    user = nil
    File.open('tmp.txt', 'w') do |wf|
      File.open('users.txt', 'r') do |f|
        while userline = f.gets
          id, name = userline.split(',')
	  if id == target_id
	    user = User.new(id, name)
	    next
	  end
          wf.print userline
        end
      end
    end

    `mv tmp.txt users.txt`

    user
  end

  def save!
    File.open('users.txt', 'a') do |f|
      f.puts "#{id},#{@name}"
    end
  end
end



