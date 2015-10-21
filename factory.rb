class Factory
  def self.new(*attributes, &block)
    Class.new do
      attributes.each do |attribute|
        define_method("#{attribute}") { instance_variable_get("@#{attribute}") }
        define_method("#{attribute}=") { |val| instance_variable_set("@#{attribute}", val) }
      end

      define_method ("[]") do |attribute|
        attribute.class == Fixnum ? instance_variable_get("@#{attributes[attribute]}") : instance_variable_get("@#{attribute}")
      end

      define_method ("[]=") do |attribute, value|
        attribute.class == Fixnum ? instance_variable_set("@#{attributes[attribute]}", value) : instance_variable_set("@#{attribute}", value)
      end

      define_method :initialize do |*values|
        attributes.length.times do |i|
          instance_variable_set("@#{attributes[i]}", values[i])
        end
      end
      class_eval(&block) if block_given?
    end
  end
end

Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

# Customer = Struct.new(:name, :address) do
#   def greeting
#     "Hello #{name}!"
#   end
# end

joe = Customer.new("John", "123 Maple, Anytown NC")

p joe.name
p joe.address
p joe['name']
p joe['address'] = 'dnipro'
p joe[:name]
p joe[:address]
p joe[0] = "Den"
p joe[0]
p joe[1]
p joe.greeting