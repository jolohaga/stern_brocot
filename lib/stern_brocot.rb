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

# Contains SternBrocot::Tree, SternBrocot::Fraction and SternBrocot::Series
#
module SternBrocot
  class Tree
    def initialize(start, depth=0)
    end
  end
  
  # A representation of a Stern-Brocot fraction.
  #
  # === Description
  # Stern-Brocot fractions are 1x2 matrices represented as fractions.  They have the following properties:
  # 1. Divisor, '/', acts as a symbol, not an operator.
  # 2. 1/0 is not exceptional.
  # 3. The summation operator, mediant, maps as 0/1 + 1/0 => 1/1.<br/>
  #    That is, fractions add together like 1x2 matrices.
  #
  # === Use
  #   require 'stern_brocot'
  #   f1 = SternBrocot::Fraction.new(0,1)
  #   => #<SternBrocot::Fraction:0x0000010097f2a8 @numerator=0, @denominator=1>
  #   f2 = SternBrocot::Fraction.new(1,0)
  #   => #<SternBrocot::Fraction:0x0000010095bb38 @numerator=1, @denominator=0>
  #   f3 = f1 + f2
  #   => #<SternBrocot::Fraction:0x0000010094bf00 @numerator=1, @denominator=1>
  #   f3.to_a
  #   => [1, 1]
  class Fraction
    attr_accessor :numerator, :denominator
    
    # Create a new Stern-Brocot fraction.
    #
    # Example:
    #   f1 = SternBrocot::Fraction.new(0,1)
    #   => #<SternBrocot::Fraction:0x00000100995e00 @numerator=0, @denominator=1>
    def initialize(numerator=0, denominator=1)
      @numerator=numerator
      @denominator=denominator
    end
    
    # Give the mediant of two fractions.
    # Returns a Stern-Brocot fraction.
    #
    # Example:
    #   f1 = SternBrocot::Fraction.new(0,1)
    #   f2 = SternBrocot::Fraction.new(1,0)
    #   f1.mediant f2
    #   => #<SternBrocot::Fraction:0x000001010ced88 @numerator=1, @denominator=1>
    def mediant(other)
      return SternBrocot::Fraction.new(self.numerator + other.numerator, self.denominator + other.denominator)
    end
    
    # Alias for mediant.
    #
    alias + mediant
    
    # Return the fraction as a String.
    # 
    def to_s
      return "#{numerator}/#{denominator}"
    end
    
    # Return the fraction as an Array.
    def to_a
      return [numerator,denominator]
    end
    
    # Return the fraction as a Rational.
    #
    # <b>Note:</b> 1/0 will return an exception.
    def to_r
      return Rational(numerator,denominator)
    end
  end
  
  class Series
  end
  
  class << self
  end
end