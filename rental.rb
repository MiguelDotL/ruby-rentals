class Rental
  #
  class << self # The `eigenclass` is an anonymous instance of the class `Class`
                # attached to a defined object, in which instance methods are
                # used as singleton methods, belonging to said defined object.
    #
    def define_getters(attributes) # replaces attr_reader for each csv column header
      attributes.each do |attribute| # ------ for each |attribute| in attributes array
        define_method(attribute.to_sym) do #  define a method on our Rental Class called |:attribute|
          # --------------------------------- which returns us the value of @|attribute| instance variable
          return instance_variable_get("@#{attribute}")
        end
      end
    end

    def define_initialize(attributes) # creates initialize method, and assigns all instance variables to args passed in
      define_method(:initialize) do |*args| # ---- define an initialize method for each argument passed into this method
        attributes.zip(args) do |attribute, arg| # create an array of arrays like this:  [[attribute, arg]...]
          # -------------------------------------- create an instance variable for each @attribute = arg
          instance_variable_set("@#{attribute}", arg)
        end
      end
    end

    #
  end
  #
end
