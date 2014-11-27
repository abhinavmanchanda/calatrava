require 'spec_helper'

describe Calatrava::Shell do
  include Aruba::Api

  let(:shell) { Calatrava::Shell.new(current_dir) }

  before(:each) do
    create_dir 'shell/support'
    write_file 'shell/support/shell.coffee', ''
    write_file 'shell/support/fragment.haml', ''
    create_dir 'shell/pages/example'
    write_file 'shell/pages/example/page.coffee', ''
    write_file 'shell/pages/example/page.haml', ''

    create_dir 'shell/stylesheets'
    write_file 'shell/stylesheets/shell.css', ''
    write_file 'shell/stylesheets/template.sass', ''
  end

  context 'coffee files' do
    subject { shell.coffee_files }

    it { is_expected.to include 'shell/support/shell.coffee' }
  end

  context 'haml files' do
    subject { shell.haml_files }

    it { is_expected.to include 'shell/support/fragment.haml' }
  end

  context 'css files' do
    subject { shell.css_files }
    
    it { is_expected.to include 'shell/stylesheets/shell.css' }
    it { is_expected.to include 'shell/stylesheets/template.sass' }
  end

  context 'features' do
    subject { shell.features }

    it 'has 1 feature' do
      expect(subject.size).to eq(1)
    end

    context 'a single feature' do
      subject { shell.features[0] }

      it { is_expected.to include :name => 'example' }
      it { is_expected.to include :coffee => ['shell/pages/example/page.coffee'] }
      it { is_expected.to include :haml => ['shell/pages/example/page.haml'] }
    end
  end
  
end
