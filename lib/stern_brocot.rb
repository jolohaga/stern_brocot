# SternBrocot
#
# Generate Stern-Brocot fractions, trees and series.
#
# Requires Ruby 1.9+
#
# Author:: Jose Hales-Garcia (mailto:jolohaga@me.com)
# Copyright:: Copyright (c) 2010 Jose Hales-Garcia
#
#
module SternBrocot
  class Tree
    def initialize(start, depth=0)
    end
  end
  
  class Fraction
    attr_accessor :numerator, :denominator
    
    def initialize(numerator=0, denominator=1)
      @numerator=numerator
      @denominator=denominator
    end
    
    def +(other)
      return SternBrocot::Fraction.new(self.numerator + other.numerator, self.denominator + other.denominator)
    end
    
    def to_s
      return "#{numerator}/#{denominator}"
    end
    
    def to_a
      return [numerator,denominator]
    end
    
    def to_r
      return Rational(numerator,denominator)
    end
  end
  
  class << self
  end
end