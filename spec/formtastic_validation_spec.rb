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

        it 'should add a valid message tag' do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation_valid_message="Thank you!"]')
        end

        it 'should allow changes to the valid message tag' do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {})])
          FormtasticValidation.valid_message = "Its correct!"
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation_valid_message="Its correct!"]')
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
          output_buffer.should have_tag('input[@validation_one="one"]')
        end

        it "should add multiple options as separate tags" do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {:one => 'one', :two => 'two'})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever"]')
          output_buffer.should have_tag('input[@validation_one="one"]')
          output_buffer.should have_tag('input[@validation_two="two"]')
        end

        it "should include the input_html" do
          @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_whatever, :name => :name, :options => {:one => 'one', :two => 'two'})])
          semantic_form_for(@bob) do |builder|
            concat(builder.input(:name, :input_html => {:three => 'three'}))
          end
          output_buffer.should have_tag('input[@validation="validates_whatever"]')
          output_buffer.should have_tag('input[@validation_one="one"]')
          output_buffer.should have_tag('input[@validation_two="two"]')
          output_buffer.should have_tag('input[@three="three"]')
        end
      end
    end

    describe "validation options" do
      it "should serialise regex as json strings" do
        @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_format_of, :name => :name, :options => {:with => /^a garden$/})])
        semantic_form_for(@bob) do |builder|
          concat(builder.input(:name))
        end
        output_buffer.should have_tag('input[@validation="validates_format_of"]')
        output_buffer.should have_tag('input[@validation_with="/^a garden$/"]')
      end

      it "should serialise array as json strings" do
        @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_inclusion_of, :name => :name, :options => {:in => %w(one two three)})])
        semantic_form_for(@bob) do |builder|
          concat(builder.input(:name))
        end
        output_buffer.should have_tag('input[@validation="validates_inclusion_of"]')
        output_buffer.should have_tag(%\input[@validation_in='["one","two","three"]']\)
      end

      it "should serialise range as array" do
        @bob.class.should_receive(:reflect_on_validations_for).with(:name).any_number_of_times.and_return([mock('MacroReflection', :macro => :validates_inclusion_of, :name => :name, :options => {:in => 1..3})])
        semantic_form_for(@bob) do |builder|
          concat(builder.input(:name))
        end
        output_buffer.should have_tag('input[@validation="validates_inclusion_of"]')
        output_buffer.should have_tag(%\input[@validation_in='[1,2,3]']\)
      end
    end
  end
end
