module Hemi
  module Loader
    def self.load_tree(tree_dir)
      if File.exist?(manifest_file = File.join(__dir__, tree_dir, "_manifest.rb"))
        require manifest_file
      else
        Dir[File.join(__dir__, tree_dir, "**", "*.rb")].sort.each do |file|
          require file
        end
      end
    end
  end
end
