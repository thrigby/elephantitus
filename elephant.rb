require 'redis'

class Elephant
  attr_accessor :id
  
  R = Redis.new

  def initialize(id)
    @id = id
  end
  
  def name
    R.get("elephants:#{id}:name")
  end
  
  def color
    R.get("elephants:#{id}:color")
  end
  
  def weight
    R.get("elephants:#{id}:weight")
  end
  
  def self.next_id
    R.incr("elephants")
  end
  
  def self.create(name, color, weight) 
    id = next_id
    R.set("elephants:#{id}:name", name)
    R.set("elephants:#{id}:color", color)
    R.set("elephants:#{id}:weight", weight)
    R.sadd("elephants:idx", id)
    return Elephant.new(id)
  end
  
  def self.find(id)
    Elephant.new(id)
  end
  
  def self.find_all
    R.smembers("elephants:idx").map { |id| Elephant.new(id) }
  end
  
  def destroy
    R.srem("elephants:idx", id)
    R.del("elephants:#{id}:name")
    R.del("elephants:#{id}:color")
    R.del("elephants:#{id}:weight")
  end
end
