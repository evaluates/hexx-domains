# encoding: utf-8

module Hexx

  module Domains

    # Scaffolder of new domain model as a separate gem
    class CLI < Hexx::CLI::Base

      # @private
      def self.source_root
        ::File.expand_path "../cli", __FILE__
      end

      desc "Scaffolds a domain model."
      namespace :domain

      argument(
        :name,
        banner: "NAME",
        desc: "The name of the module",
        required: true,
        type: :string
      )

      class_option(
        :author,
        aliases: "-a",
        banner: "Name Family",
        desc: "The name of the author",
        default: [],
        type: :array
      )

      class_option(
        :username,
        aliases: "-u",
        banner: "username",
        desc: "The username of the author on Github",
        type: :string
      )

      class_option(
        :email,
        aliases: "-e",
        banner: "email",
        desc: "The email of the author on Github",
        type: :string
      )

      class_option(
        :ruby,
        aliases: "-r",
        banner: "2.1",
        desc: "The ruby API to support: 1.9, 2.0, 2.1",
        default: "2.1",
        type: :string
      )

      class_option(
        :dummy,
        aliases: "-d",
        desc: "Use a dummy app",
        default: false,
        type: :boolean
      )

      class_option(
        :git,
        aliases: "-g",
        desc: "Initialize new git repository",
        default: false,
        type: :boolean
      )

      class_option(
        :bundle,
        aliases: "-b",
        desc: "Run bundler",
        default: false,
        type: :boolean
      )

      # @private
      def populate_core_files
        copy_folder "root", project.file
        self.destination_root = "#{ destination_root }/#{ project.file }"
      end

      # @private
      def add_gemspec
        template "gemspec.erb", "#{ project.file }.gemspec"
      end

      # @private
      def add_version
        template "version.erb", "lib/#{ project.path }/version.rb"
      end

      # @private
      def add_loader
        template "lib.erb", "lib/#{ project.file }.rb"
      end

      # @private
      def add_module
        return unless project.namespaces.any?
        template "module.erb", "lib/#{ project.path }.rb"
      end

      # @private
      def add_suit
        in_root { `hexx-suit install` }
        empty_directory "spec/tests"
      end

      # @private
      def add_dummy
        return unless options["dummy"]
        in_root { Hexx::Dependencies::CLI.start %w() }
      end

      # @private
      def add_git_repository
        return unless options["git"]
        in_root { `git init` }
      end

      # @private
      def run_bundler
        return unless options["bundle"]
        in_root { `bundle` }
      end

      private

      def year
        @year ||= Time.now.strftime("%Y")
      end

      def project
        @project ||= Hexx::CLI::Name.new name
      end

      def author
        @author ||= begin
          value = options["author"]
          value.any? ? value.map(&:capitalize).join(" ") : "@todo: author"
        end
      end

      def user
        @user ||= (options["username"] || "@todo: username").downcase
      end

      def email
        @email ||= (options["email"] || "@todo: email").downcase
      end

      def ruby
        @ruby ||= begin
          value = options["ruby"].split(".")[0..1].join(".")
          %w(1.9 2.0 2.1).include?(value) ? value : "2.1"
        end
      end

      def rubies
        {
          "1.9" => [
            "'1.9.3'", "'2.2'", "ruby-head",
            "rbx-2 --1.9", "rbx-2 --2.2",
            "jruby-1.7-19mode", "jruby-9.0.0.0.pre2", "jruby-head"
          ],
          "2.0" => [
            "'2.0'", "'2.2'", "ruby-head",
            "rbx-2 --2.0", "rbx-2 --2.2",
            "jruby-9.0.0.0.pre2", "jruby-head"
          ],
          "2.1" => [
            "'2.1'", "'2.1'", "ruby-head",
            "rbx-2 --2.1", "rbx-2 --2.2",
            "jruby-9.0.0.0.pre2", "jruby-head"
          ],
          "2.2" => [
            "'2.2'", "ruby-head",
            "rbx-2 --2.2",
            "jruby-9.0.0.0.pre2", "jruby-head"
          ]
        }[ruby]
      end

    end # module Hexx

  end # module Domains

end # class CLI
