# frozen_string_literal: true

module Oblivion
  class Uglifier < BaseProcessor
    def self.process(ast)
      new(Renamer.new).process(ast)
    end

    def on_class(node)
      MethodFinder.methods_of_class(node, @renamer)
      node.with_processed_children ClassUglifier.new(@renamer)
    end

    alias on_sclass on_class

    private

    def initialize(renamer)
      super()
      @renamer = renamer
    end
  end
end
