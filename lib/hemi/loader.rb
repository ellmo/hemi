module Hemi
  module Loader
    def self.load_tree(tree_dir, relative: false)
      if File.exist?(manifest_file = File.join(__dir__, tree_dir, "_manifest.rb"))
        relative ? require_relative(manifest_file) : require(manifest_file)
      else
        Dir[File.join(__dir__, tree_dir, "**", "*.rb")].sort.each do |file|
          relative ? require_relative(file) : require(file)
        end
      end
    end
  end
end
