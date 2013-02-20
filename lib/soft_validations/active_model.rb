module SoftValidations
  module ActiveModel

    def self.included(base)
      super
      base.class_eval do
        include InstanceMethods
        define_model_callbacks :soft_validate
        class << self
          alias_method :soft_validate, :before_soft_validate
        end
      end
      base.extend ClassMethods
    end

    module InstanceMethods
      # Returns true if there are no messages in the warnings collection.
      def complete?
        warnings.clear
        run_callbacks :soft_validate
        warnings.empty?
      end

      # Returns the warnings collection, an instance of Errors. The warnings collection is a
      # different object than the errors collection. However, you can interact with the warnings
      # collection in the same way that you interact with errors. For example:
      #
      #   employee.warnings[:first_name]
      #
      # A record can have errors and return false for valid? and yet
      # at the same time have no warnings and return true for complete?.
      def warnings
        @warnings ||= ::ActiveModel::Errors.new(self)
      end
    end

    # Adds a soft_validation method or block to the class. This provides a
    # descriptive declaration of the object's desired state in order to be
    # considered complete. The methods or block passed to
    # soft_validate should add a message to the class's warning collection.
    #
    # Example with a symbol pointing to a method:
    #
    #   class Employee
    #     extend ActiveModel::Callbacks
    #     include SoftValidations::ActiveModel
    #
    #     soft_validate :should_have_first_name
    #
    #     attr_accessor :first_name
    #
    #     def should_have_first_name
    #       warnings.add(:first_name, "shouldn't be blank") unless self.first_name.present?
    #     end
    #   end
    #
    # Or with a block:
    #
    #   class Employee
    #     extend ActiveModel::Callbacks
    #     include SoftValidations::ActiveModel
    #     attr_accessor :first_name
    #     soft_validate do |e|
    #       e.warnings.add(:first_name, "shouldn't be blank") unless e.first_name.present?
    #     end
    #   end
    module ClassMethods

    end

  end
end
