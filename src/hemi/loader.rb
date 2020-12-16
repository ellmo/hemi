module Loader
  def load_tree(tree_dir)
    Dir[File.join(__dir__, tree_dir, "**", "*.rb")].sort.each do |file|
      require file
    end
  end
end