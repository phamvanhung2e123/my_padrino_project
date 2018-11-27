This is demo project to reproduce dependency bug
#### How to reproduce require dependency bug
- Edit Gemfile to change padrino-framework and run `bunlde install`
```
# Padrino Stable Gem
gem 'padrino', :github => 'padrino/padrino-framework'
# Padrino 0.12.3
# gem 'padrino', '0.12.3'
# Padrino fix loader
# gem 'padrino', :github => 'phamvanhung2e123/padrino-framework', :ref => 'change_dependency_order'
```

#### Padrino Stable Gem
- When we use last Padrino, `uninitialized constant ALib` is raised
```
➜  my_padrino_project git:(master) RACK_ENV=test bundle exec padrino c
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0030s) /Users/vanhungpham/git/my_padrino_project/lib/a_lib.rb
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant DependentLib
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0027s) /Users/vanhungpham/git/my_padrino_project/lib/dependent_lib.rb
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0027s) /Users/vanhungpham/git/my_padrino_project/app/app.rb
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0033s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant ALib
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0036s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:02:45 Removed constant ModelWithNoDepOnLib from Object
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant ModelWithNoDepOnLib::MyCache
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0046s) /Users/vanhungpham/git/my_padrino_project/app/models/my_cache.rb
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0029s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant ALib
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0029s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:02:45  LOADING (0.0027s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant ALib
  ERROR - 27/Nov/2018 18:02:45 NameError - uninitialized constant ALib:
 /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb:1:in `<top (required)>'
  DEVEL - 27/Nov/2018 18:02:45 Removed constant ModelWithNoDepOnLib from Object
  DEVEL - 27/Nov/2018 18:02:45 Removed constant MyProject::App from MyProject
  DEVEL - 27/Nov/2018 18:02:45 Cyclic dependency reload for NameError: uninitialized constant ALib
  ERROR - 27/Nov/2018 18:02:45 NameError - uninitialized constant ALib:
 /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb:1:in `<top (required)>'
bundler: failed to load command: padrino (/Users/vanhungpham/git/my_padrino_project/vendor/bundle/ruby/2.3.0/bin/padrino)
NameError: uninitialized constant ALib
```

#### Padrino fix loader
- When we use this fix https://github.com/phamvanhung2e123/padrino-framework/commit/ba66049cf98887b8e78f24dd02a6b910c266ce44 , `NameError` is not rasied 
```
➜  my_padrino_project git:(master) ✗ RACK_ENV=test bundle exec padrino c
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0029s) /Users/vanhungpham/git/my_padrino_project/lib/a_lib.rb
  DEVEL - 27/Nov/2018 18:04:31 Cyclic dependency reload for NameError: uninitialized constant DependentLib
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0030s) /Users/vanhungpham/git/my_padrino_project/lib/dependent_lib.rb
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0025s) /Users/vanhungpham/git/my_padrino_project/lib/a_lib.rb
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0033s) /Users/vanhungpham/git/my_padrino_project/app/app.rb
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0043s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:04:31 Removed constant ModelThatDependsOnLib from Object
  DEVEL - 27/Nov/2018 18:04:31 Cyclic dependency reload for NameError: uninitialized constant ModelThatDependsOnLib::MyCache
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0061s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:04:31 Removed constant ModelWithNoDepOnLib from Object
  DEVEL - 27/Nov/2018 18:04:31 Cyclic dependency reload for NameError: uninitialized constant ModelWithNoDepOnLib::MyCache
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0057s) /Users/vanhungpham/git/my_padrino_project/app/models/my_cache.rb
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0042s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:04:31  LOADING (0.0030s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:04:31    SETUP (0.0532s) MyProject::App
  DEVEL - 27/Nov/2018 18:04:31 Loaded Padrino in 0.125813 seconds
=> Loading test console (Padrino v.0.14.4)
=> Loading Application MyProject::App
irb(main):001:0> ModelWithNoDepOnLib
=> ModelWithNoDepOnLib
irb(main):002:0> ModelThatDependsOnLib
=> ModelThatDependsOnLib
irb(main):003:0>
```

#### Padrino ('0.12.3') old version
- When we use old version, `uninitialized constant ModelWithNoDepOnLib` is raised
```
➜  my_padrino_project git:(master) ✗ RACK_ENV=test bundle exec padrino c
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0035s) /Users/vanhungpham/git/my_padrino_project/lib/a_lib.rb
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant DependentLib
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0037s) /Users/vanhungpham/git/my_padrino_project/lib/dependent_lib.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0042s) /Users/vanhungpham/git/my_padrino_project/app/app.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0057s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ALib
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0064s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ModelWithNoDepOnLib::MyCache
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0039s) /Users/vanhungpham/git/my_padrino_project/app/models/my_cache.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0037s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ALib
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0087s) /Users/vanhungpham/git/my_padrino_project/app/models/model_with_no_dep_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0043s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ALib
  ERROR - 27/Nov/2018 18:03:33 NameError - uninitialized constant ALib:
 /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb:1:in `<top (required)>'
  DEVEL - 27/Nov/2018 18:03:33 Removed constant MyProject::App from MyProject
  DEVEL - 27/Nov/2018 18:03:33 Removed constant ModelWithNoDepOnLib from Object
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ALib
  ERROR - 27/Nov/2018 18:03:33 NameError - uninitialized constant ALib:
 /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb:1:in `<top (required)>'
  DEVEL - 27/Nov/2018 18:03:33 Cyclic dependency reload for NameError: uninitialized constant ALib
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0045s) /Users/vanhungpham/git/my_padrino_project/lib/a_lib.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0035s) /Users/vanhungpham/git/my_padrino_project/app/app.rb
  DEVEL - 27/Nov/2018 18:03:33  LOADING (0.0043s) /Users/vanhungpham/git/my_padrino_project/app/models/model_that_depends_on_lib.rb
  DEVEL - 27/Nov/2018 18:03:33    SETUP (0.0163s) MyProject::App
  DEVEL - 27/Nov/2018 18:03:33 Loaded Padrino in 0.177931 seconds
=> Loading test console (Padrino v.0.12.3)
=> Loading Application MyProject::App
irb(main):001:0> ModelWithNoDepOnLib
NameError: uninitialized constant ModelWithNoDepOnLib
Did you mean?  ModelThatDependsOnLib
```