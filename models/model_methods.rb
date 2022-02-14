require 'json'

module ModelMethods
    module InstanceMethods
        def save
            if self.class.validate(self)
                if self.id.nil? or self.class.find_by_id(self.id).nil?
                    object = ModelMethods::compose_object(self.class.attributes, self)
                    all_objects = self.class.all
                    all_objects << object
                    self.class.save_data(all_objects)
                else
                    self.class.update(self)
                end
            end
        end
    end

    module ClassMethods
        $level = "level1"

        def all
            load_input_data[ModelMethods::pluralize(self.name)] || []
        end

        def load_input_data
            begin
                JSON.parse(File.read(File.join(File.dirname(__FILE__), "../#{$level}/data/input.json")))
            rescue JSON::ParserError => e
                raise "Error when parsing the input.json file: #{e}"
            end 
        end

        def find_by_id(object_id)
            find_one_by('id', object_id)
        end
    
        def generate_id
            last_id + 1
        end
    
        def last_id
            all.map {|object| object['id']}.sort.last.to_i
        end

        def update(object)
            object_idx = object.class.find_index(object.id)
            if object_idx > -1 and object.class.validate(object)
                _object = ModelMethods::compose_object(self.attributes, object)
                all_objects = self.all
                all_objects[object_idx] = _object
                self.save_data(all_objects)
            else
                raise "#{object.class} Not found with ID: #{object.id}"
            end
        end

        def find_index(object_id)
            index = -1
            find_all.each_with_index do |object, idx|
                if object.id == object_id
                    index = idx
                    break
                end
            end
            index
        end

        def save_data(all_objects)
            begin
                input_data = load_input_data
                input_data[ModelMethods::pluralize(self.name)] = all_objects
                File.open(File.join(File.dirname(__FILE__), "../#{$level}/data/input.json"),"w+") { |f| f.write JSON.pretty_generate(input_data) }
                true
            rescue Exception => e
                raise "#{self.name} not save with errors : #{e}"
            end
        end

        def find_one_by(attribute_name, object_id)
            object = all.find { |obj| obj[attribute_name] == object_id }
            object.nil? ? nil : self.new(ModelMethods::compose_object(self.attributes, object))
        end

        def find_all_by(attribute_name, object_id)
            all.select {|object| object[attribute_name] == object_id}.map{|object| self.new(ModelMethods::compose_object(self.attributes, object))}
        end
        
        def find_all
            all.map{|object| self.new(ModelMethods::compose_object(self.attributes, object))}
        end
    end

    def self.pluralize(string)
        string.downcase + 's'
    end

    def self.compose_object(attributes, object)
        json_object = {}
        attributes.each do |attribute|
            json_object[attribute] = object.instance_of?(Hash) ?  object[attribute.to_s] : object.instance_variable_get(("@"+ attribute.to_s).to_sym)
        end
        json_object
    end
end