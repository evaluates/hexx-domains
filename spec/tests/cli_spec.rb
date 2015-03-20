# encoding: utf-8

describe Hexx::Domains::CLI, :sandbox do

  shared_examples "adding an email" do |email|

    it "[adds email to .gemspec]" do
      content = read_in_sandbox "foo-bar/foo-bar.gemspec"
      expect(content).to include email
    end

    it "[adds email to LICENSE]" do
      content = read_in_sandbox "foo-bar/LICENSE"
      expect(content).to include email
    end

  end # shared_examples

  shared_examples "adding a user" do |user|

    it "[adds user to .gemspec]" do
      content = read_in_sandbox "foo-bar/foo-bar.gemspec"
      expect(content).to include user
    end

    it "[adds user to README]" do
      content = read_in_sandbox "foo-bar/README.md"
      expect(content).to include user
    end

    it "[adds user to LICENSE]" do
      content = read_in_sandbox "foo-bar/LICENSE"
      expect(content).to include user
    end

  end # shared_examples

  shared_examples "adding an author" do |author|

    it "[adds author to .gemspec]" do
      content = read_in_sandbox "foo-bar/foo-bar.gemspec"
      expect(content).to include author
    end

    it "[adds author to LICENSE]" do
      content = read_in_sandbox "foo-bar/LICENSE"
      expect(content).to include author
    end

  end # shared_examples

  shared_examples "creating a dummy app" do

    it "[adds files]" do
      %w(
        foo-bar/lib/foo/bar/configurator.rb
        foo-bar/spec/dummy/config/initializers/foo-bar.rb
        foo-bar/spec/dummy/lib/dummy.rb
      ).each { |file| expect(file).to be_present_in_sandbox }
    end

    it "[calls dummy app]" do
      content = read_in_sandbox "foo-bar/spec/spec_helper.rb"
      expect(content).to include "dummy/lib/dummy"
    end

  end # shared_examples

  shared_examples "creating a gem" do

    it "[adds files]" do
      %w(
        foo-bar/lib/foo-bar.rb
        foo-bar/lib/foo/bar.rb
        foo-bar/lib/foo/bar/version.rb
        foo-bar/spec/spec_helper.rb
        foo-bar/spec/tests
        foo-bar/.coveralls.yml
        foo-bar/.gitignore
        foo-bar/.rspec
        foo-bar/.travis.yml
        foo-bar/.yardopts
        foo-bar/Gemfile
        foo-bar/Guardfile
        foo-bar/LICENSE
        foo-bar/README.md
        foo-bar/Rakefile
        foo-bar/foo-bar.gemspec
      ).each { |file| expect(file).to be_present_in_sandbox }
    end

  end # shared_examples

  shared_examples "initializing git repository" do

    it "[has .git]" do
      expect("foo-bar/.git").to be_present_in_sandbox
    end

  end # shared_examples

  shared_examples "skipping a dummy app" do

    it "[doesn't add files]" do
      %w(
        foo-bar/foo/bar/configurator.rb
        foo-bar/spec/dummy/config/initializers/foo-bar.rb
        foo-bar/spec/dummy/lib/dummy.rb
      ).each { |file| expect(file).to be_absent_in_sandbox }
    end

    it "[calls lib]" do
      content = read_in_sandbox "foo-bar/spec/spec_helper.rb"
      expect(content).to include "require \"foo-bar\""
    end

  end # shared_examples

  shared_examples "skipping git repository" do

    it "[has no .git]" do
      expect("foo-bar/.git").to be_absent_in_sandbox
    end

  end # shared_examples

  shared_examples "supporting ruby" do |ruby|

    it "[adds ruby to README]" do
      content = read_in_sandbox "foo-bar/README.md"
      expect(content).to include ruby
    end

    it "[adds rmv to .travis.yml]" do
      versions = {
        "1.9" => [
          "1.9.3", "ruby-head",
          "rbx-2 --1.9", "rbx-2 --2.0",
          "jruby-1.7-19mode", "jruby-head-21mode"
        ],
        "2.0" => ["2.0", "ruby-head", "rbx-2 --2.0", "jruby-head-20mode"],
        "2.1" => ["2.1", "ruby-head", "rbx-2 --2.0", "jruby-head-21mode"]
      }
      content = read_in_sandbox "foo-bar/.travis.yml"
      versions[ruby].each { |version| expect(content).to include version }
    end

  end # shared_examples

  describe ".start", :capture do

    subject { try_in_sandbox { described_class.start params } }

    context "foo-bar" do

      let(:params) { %w(foo-bar) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "adding an email", "@todo: email"
      it_behaves_like "adding a user", "@todo: user"
      it_behaves_like "adding an author", "@todo: author"
      it_behaves_like "supporting ruby", "2.1"
      it_behaves_like "skipping a dummy app"
      it_behaves_like "skipping git repository"

    end # context

    context "foo-bar -u bar" do

      let(:params) { %w(foo-bar -u bar) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "adding a user", "bar"

    end # context

    context "foo-bar -a bar baz" do

      let(:params) { %w(foo-bar -a bar baz) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "adding an author", "Bar Baz"

    end # context

    context "foo-bar -e bar@baz.com" do

      let(:params) { %w(foo-bar -e bar@baz.com) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "adding an email", "bar@baz.com"

    end # context

    context "foo-bar -r 1.9" do

      let(:params) { %w(foo-bar -r 1.9) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "supporting ruby", "1.9"

    end # context

    context "foo-bar -r 2.0" do

      let(:params) { %w(foo-bar -r 2.0) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "supporting ruby", "2.0"

    end # context

    context "foo-bar -r 2.1" do

      let(:params) { %w(foo-bar -r 2.1) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "supporting ruby", "2.1"

    end # context

    context "foo-bar -d" do

      let(:params) { %w(foo-bar -d) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "creating a dummy app"

    end # context

    context "foo-bar -g" do

      let(:params) { %w(foo-bar -g) }
      before { subject }

      it_behaves_like "creating a gem"
      it_behaves_like "initializing git repository"

    end # context

  end # describe .start

end # describe Hexx::Domains::CLI
