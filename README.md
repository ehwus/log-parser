# Log Parser 🪵

### Introduction

The aim of this project was to create a Ruby application that can take a `.log` file (given as a path in argv) and turn it into:

- A list (from largest to smallest) of total accesses on a page by page basis when given IP addresses and the page name.
- A list (again from largest to smallest) of unique accesses on a page by page basis with the same data.

This implementation assumes that all individual data is separated by a line break, and in a format exactly like the following:
`/home 184.123.665.067`

### Usage

- Requires Ruby (I used v3.1.2)
- Clone the repository
- `$ bundle install`
- `$ ruby parser.rb path/to/log.log` (webserver.log is included in this repository as an example)

🧪 Testing has been done using rspec, and to run the suite use `$ rspec` - this will also generate a SimpleCov report, which is currently sitting at 99.32% coverage. The missing piece would be to mock the file system to simulate the parsing function in the `LogParser` class.
