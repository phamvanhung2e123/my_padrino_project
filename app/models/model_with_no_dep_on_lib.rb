class ModelWithNoDepOnLib
  include ModelCache
  def self.hello
    puts "hello, world!"
  end
end
