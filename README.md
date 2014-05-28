# Acts as file

`acts_as_file` makes your field act as a file.
The content of the field is stored into a file on calling `#save` method, 
and is loaded from the file on calling its accessor method. 

[![Build Status](https://travis-ci.org/sonots/acts_as_file.svg)](https://travis-ci.org/sonots/acts_as_file)
[![Coverage Status](https://coveralls.io/repos/sonots/acts_as_file/badge.png)](https://coveralls.io/r/sonots/acts_as_file)

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'acts_as_file'
```

And then execute:

```plain
$ bundle
```

## Examples

ActiveRecord is not required, but let me write an example for it.

```ruby
class Post < ActiveRecord::Base
  include ActsAsFile
  def filename
    "posts/#{self.id}_body.txt"
  end
  acts_as_file :body => self.instance_method(:filename)
end

# store
post = Post.new
post.body = 'content'
post.save # save the content into the file of `#filename`
          # create the directory if not exist
# load
post = Post.first
puts post.body # load the content from the file of `#filename`
post.destroy   # remove the file
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

* Copyright (c) 2014 Naotoshi Seo. See [LICENSE](LICENSE) for details.
