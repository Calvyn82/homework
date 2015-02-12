# Ruby Project Layout

Basic project structure "My Project:"

    my_project/
      bin/            # file to run:  my_project
      data/           # non-code data needed
      doc/            # documentation for My Project
      examples/       # puts examples for users (not you!) of this code
      lib/            # 99.99999% of all code lives
        my_project/
          my_object.rb     # the MyObject file
          other_object.rb  # the OtherObject file
          # ...
        my_project.rb # the main file you load
      Rakefile        # Rake code for automating tasks
      README.md       # first thing user sees:  need to know stuff
      spec/ or test/  # automated tests (test is older, spec is standard now)
      vendor/         # other people's code

## Binaries

The file `bin/my_project`:

    #!/usr/bin/env ruby
    
    require_relative "../lib/my_project"
    
    MyProject::MyObject.new(ARGV).run

Three key points:

1. Has _Shenbang_ line telling this OS what kind of code this is
2. Loads code from `lib/`
3. Setups up and starts the code (usually one line)

## Library Code

A sample `lib/my_project.rb`:

    require_relative "my_project/my_object"
    require_relative "my_project/other_object"
    # ...

A sample `lib/my_project/my_object.rb`:

    require_relative "dependency"  # if needed

    module MyProject
      class MyObject
        def initialize(some_thing)  # not a dependency
          @some_thing = some_thing
          @dependency = Dependency.new  # is a dependency
        end
        
        # ...
      end
    end

Things to note:

1. Consistent naming `lib/my_project/my_object.rb` holds `MyProject::MyObject`
2. Namespacing `MyObject` is in `MyProject`
3. A file should always load what it needs to run (Only the class names used!)
4. It's `MyProject::MyObject` outside `MyProject` or `MyObject` inside
