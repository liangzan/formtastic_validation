require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FormtasticValidation#input" do
  include FormtasticValidationSpecHelper

  before do
    @output_buffer = ''
    setup_mocks
  end

  describe "validation and options attributes" do
    describe "when object is given" do
      describe 'and validations were called for the method' do

        it 'should add a validation tag' do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever"]')
        end

        it "should add multiple validation tags separated by space" do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {}), mock('MacroReflection', :macro => :validates_anything, :name => :name, :options => {})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever validates_anything"]')
        end

        it 'should add a single option as tag' do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {:one => 'one'})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever"]')
          output_buffer.should have_tag('input[@one="one"]')
        end

        it "should add multiple options as separate tags" do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {:one => 'one', :two => 'two'})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever"]')
          output_buffer.should have_tag('input[@one="one"]')
          output_buffer.should have_tag('input[@two="two"]')
        end

      end

    end
  end
end
