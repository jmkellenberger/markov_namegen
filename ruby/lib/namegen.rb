# frozen-string-literal: false

# Creates a dictionary with prefixes as keys, and an array of possible suffixes
# as values, to be used by NameGen class
class MarkovDict
  def initialize
    @dict = {}
  end

  def add_key(prefix, suffix)
    @dict.include?(prefix) ? @dict[prefix].push(suffix) : @dict[prefix] = [suffix]
  end

  def fetch_suffix(prefix)
    @dict[prefix].sample
  end
end

# Builds a new name by constructing a MarkovDict from an array of namees.
# New instances take 2 parameters:
#   names(array): list of source names
#   chainlength(num 1-10): determines order of markov chain, defaulted to 2 for best mix of
#     readability and uniqueness. Note: with a small source list, values of 3 or higher
#     return names too similar to input
#
# To generate a name after creating an instance of NameGen, call #new_name/1
# #new_name(unique:) takes a single boolean parameter, defaulted to true.
#   if true: only output names that are not in the original list
#   if false: will output names even if they match names in original list
class NameGen
  CHAIN_ERROR = 'Chain length must be between 1 and 10.'.freeze
  DATA_ERROR = 'Invalid name data.'.freeze

  def initialize(names, chainlength = 2)
    @mdict = MarkovDict.new
    @source_names = []
    @chainlen = chainlength
    build_dict(names)
  end

  def build_dict(names)
    raise CHAIN_ERROR unless @chainlen.between?(1, 10)
    raise DATA_ERROR unless names.instance_of? Array

    names.each do |name|
      name = name.strip
      namelen = name.length
      @source_names.push(name)
      str = ' ' * @chainlen + name

      add_keys(str, namelen)
    end
  end

  def add_keys(str, namelen)
    0.upto(namelen - 1) { |i| @mdict.add_key(str[i..i + @chainlen - 1], str[i + @chainlen]) }
    @mdict.add_key(str[namelen..namelen + @chainlen - 1], "\n")
  end

  def build_name
    prefix = ' ' * @chainlen
    name = ''
    suffix = ''

    loop do
      suffix = @mdict.fetch_suffix(prefix)
      return namecase(name) if suffix == "\n" || name.length > 9

      name += suffix
      prefix = prefix[1..] + suffix
    end
    namecase(name)
  end

  def new_name(unique: true)
    name = build_name
    return name unless unique

    @source_names.include?(name) ? new_name : name
  end

  # Credit: vol7ron @ https://stackoverflow.com/a/28288071/19434324
  def namecase(string)
    string.downcase.split(/(\s)/).map.with_index{ |x, i|
      i.zero? || x.match(/^(?:a|is|of|the|and)$/).nil? ? x.capitalize : x
    }.join
  end
end
