require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SoftValidations" do
  class Employee
    extend ActiveModel::Callbacks
    include SoftValidations::ActiveModel
    attr_accessor :first_name
    attr_accessor :last_name
    def recommend_first_name_not_blank
      warnings.add :first_name, "should not be blank" unless self.first_name.present?
    end
  end

  subject { Employee.new }

  before do
    Employee.reset_callbacks(:soft_validate)
  end

  describe "soft_validate with method" do
    before do
      Employee.soft_validate :recommend_first_name_not_blank
    end

    it "should call the callback" do
      subject.should_receive(:recommend_first_name_not_blank).and_call_original
      subject.complete?
    end

    it "should not be complete" do
      subject.should_not be_complete
    end

    it "should have a warning on first_name" do
      subject.complete?
      subject.warnings[:first_name].should == [ "should not be blank" ]
    end
  end

  describe "soft_validate with block" do
    before do
      Employee.soft_validate do
        @block_called = true
        warnings.add :first_name, "should not be blank" unless self.first_name.present?
      end
    end

    it "should call the block" do
      subject.complete?
      subject.instance_variable_get("@block_called").should be_true
    end

    it "should not be complete" do
      subject.should_not be_complete
    end

    it "should have a warning on first_name" do
      subject.complete?
      subject.warnings[:first_name].should == [ "should not be blank" ]
    end
  end

  describe "complete?" do
    it "should be true when no validations present" do
      subject.should be_complete
    end

    context "when there is warnings" do
      before do
        Employee.soft_validate :recommend_first_name_not_blank
      end

      it "should be false" do
        subject.should_not be_complete
      end

      it "should be true when warnings pass" do
        subject.first_name = "Foo"
        subject.should be_complete
      end
    end
  end

end
