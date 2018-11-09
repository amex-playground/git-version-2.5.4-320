require "option_parser"

require "file_utils"

require "../git_version"

dev_branch = "dev"
folder = FileUtils.pwd

OptionParser.parse! do |parser|
  parser.banner = "Usage: git_version [arguments]"
  parser.on("-folder FOLDER", "--folder=FOLDER", "Execute the command in the defined folder") { |f| folder = f }
  parser.on("-dev-branch BRANCH", "--dev-branch=BRANCH", "Specifies the development branch") { |branch| dev_branch = branch }
  parser.on("-h", "--help", "Show this help") { puts parser }
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

git = GitVersion::Git.new(dev_branch, folder)

puts "#{git.get_version}"
