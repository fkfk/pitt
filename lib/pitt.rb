require "rubygems"
require "pit"

class Pitt
  include Pit
  def self.set(name, opts={})
    s_opts = opts.keys.all? {|k| k.is_a? Symbol}? self.to_strings(opts) : opts
    Pit.set(name, opts)
  end

  def self.get(name, opts={})
    s_opts = opts.keys.all? {|k| k.is_a? Symbol}? self.to_strings(opts) : opts
    conf = Pit.get(name, s_opts)
    opts.keys.all? {|k| k.is_a? String}? self.to_symbols(conf) : conf
  end

  def self.switch(name, opts={})
    s_opts = opts.keys.all? {|k| k.is_a? Symbol}? self.to_strings(opts) : opts
    Pit.switch(name, opts)
  end

  protected
  def self.to_symbols(opts)
    s_opts = {}
    opts.each do |k,v|
      s_opts[k.to_sym] = v
    end
    s_opts
  end

  def self.to_strings(opts)
    s_opts = {}
    opts.each do |k,v|
      s_opts[k.to_s] = v
    end
    s_opts
  end

  def self.config
    Pit.config
  end
end
