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
  require 'matrix'
  # The identity transformation matrix
  #
  Id = Matrix.I(2)
  # The left branch transformation matrix
  #
  Left = Matrix[[1,1],[0,1]]
  
  # The right branch transformation matrix
  #
  Right = Matrix[[1,0],[1,1]]
  
  matrix_extensions = %q{
    def left_ancestor()
      column(0)
    end
    def right_ancestor()
      column(1)
    end
    def mediant()
      left_ancestor+right_ancestor
    end}
  vector_extensions = %q{
    def numerator()
      self[1]
    end
    def denominator()
      self[0]
    end
    def to_s()
      "#{numerator}/#{denominator}"
    end}
  Matrix.module_eval(matrix_extensions)
  Vector.module_eval(vector_extensions)
  
  class Tree
    attr_accessor :left, :right, :depth, :tree
    
    # A representation of a Stern-Brocot tree.
    #
    # === Description
    #
    # === Use
    #
    #
    def initialize(left=SternBrocot::Fraction.new(0,1), right=SternBrocot::Fraction.new(1,0), depth=0)
      @left = left
      @right = right
      @depth = depth
      @tree = Array.new(depth)
    end
    
    class << self
    end
  end
  
  # A representation of a Stern-Brocot fraction.
  #
  # === Description
  # Stern-Brocot fractions are 1x2 vectors represented as fractions.  They have the following properties:
  # 1. Divisor, '/', acts as a symbol, not an operator.
  # 2. 1/0 is not exceptional.
  # 3. The summation operator, mediant, maps as 0/1 + 1/0 => 1/1.<br/>
  #    That is, fractions add together like 1x2 matrices.
  #
  # === Use
  #   require 'stern_brocot'
  #   irb(main):041:0> f1 = SternBrocot::Fraction.new(0,1)
  #   => #<SternBrocot::Fraction:0x000001009f5048 @fraction=Vector[0, 1]>
  #   irb(main):042:0> f2 = SternBrocot::Fraction.new(1,0)
  #   => #<SternBrocot::Fraction:0x000001009dcf80 @fraction=Vector[1, 0]>
  #   irb(main):043:0> f3 = f1 + f2
  #   => #<SternBrocot::Fraction:0x000001009d5998 @fraction=Vector[1, 1]>
  #   irb(main):044:0> f3.to_a
  #   => [1, 1]
  class Fraction
    attr_accessor :fraction, :ancestors, :signature
    # Create a new Stern-Brocot fraction.
    #
    # Example:
    #   f1 = SternBrocot::Fraction.new(0,1)
    #   => #<SternBrocot::Fraction:0x000001009ff7a0 @fraction=Vector[0, 1]>
    def initialize(numerator=0, denominator=1)
      @fraction = Vector[denominator,numerator]
    end
    
    # Return the numerator.
    #
    def numerator
      fraction.numerator
    end
    
    # Return the denomiator
    #
    def denominator
      fraction.denominator
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
      return SternBrocot::Fraction.new(self.numerator+other.numerator, self.denominator+other.denominator)
    end
    
    # Return the left ancestor
    #
    def left_ancestor
      ancestors.left_ancestor
    end
    
    # Return the right ancestor
    #
    def right_ancestor
      ancestors.right_ancestor
    end
    
    # Alias for mediant.
    #
    alias + mediant
    
    # Return the fraction as a String.
    # 
    def to_s
      return "#{fraction.to_s}"
    end
    
    # Return the fraction as an Array.
    def to_a
      return fraction.to_a
    end
    
    # Return the fraction as a Rational.
    #
    # <b>Note:</b> 1/0 will return an exception.
    def to_r
      return Rational(numerator,denominator)
    end
    
    class << self
      # Map the fraction's signature to its matrix
      #
      # Example:
      #   SternBrocot::Fraction.map_s("LRRL")
      #   => Matrix[[3, 4], [2, 3]]
      #
      def map_s(string)
        rep = SternBrocot::Id
        string.split("").each do |letter|
          rep *=
          case letter
          when "L","0"
            SternBrocot::Left
          when "R","1"
            SternBrocot::Right
          when "I"
            SternBrocot::Id
          end
        end
        rep
      end
      
      def new_with_s(signature)
        matrix = self.map_s(signature)
        SternBrocot::Fraction.new_with_m(matrix,signature)
      end
      
      def new_with_m(matrix,signature=nil)
        fraction = SternBrocot::Fraction.new(matrix.mediant.numerator,matrix.mediant.denominator)
        fraction.ancestors = matrix
        fraction.signature = signature
        fraction
      end
    end
  end
  
  class Series
  end
end