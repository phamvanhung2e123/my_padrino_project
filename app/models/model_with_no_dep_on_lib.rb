class ModelWithNoDepOnLib
  include MyCache
  def self.hello
    puts "hello, world!"
  end
end
