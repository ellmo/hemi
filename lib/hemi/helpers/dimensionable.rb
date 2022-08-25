module Dimensionable
  # @position   = nil
  # @size       = nil
  # @parent     = nil
  # @anchor     = nil
  # @dimensions = nil

  # ERR__ARRAY_COUNT_WRONG   = "Size Array can be 1 or 2 elements".freeze
  ERR__UNRECOG_SIZE_FORMAT = "Unrecognized size format".freeze

  attr_reader :anchor

  def parent
    @resolved_parent ||=  case @parent # rubocop:disable Naming/MemoizedInstanceVariableName
                          when nil
                            Hemi::Render::Window.instance
                          when :root
                            Hemi::Render::Window.instance.container
                          end
  end

  def size
    @resolved_size ||=  case @size # rubocop:disable Naming/MemoizedInstanceVariableName
                        when :full
                          parent.size
                        when Array # handle exceptions for non 2-element arrays
                          resolve_array_size
                        when Struct
                          raise NotImplementedError, "Struct data type not supported yet"
                        end
  end

  def position
    @position ||= Position.new(**resolve_position)
  end

private

  def resolve_position
    return { x: 0, y: 0 } unless parent && anchor

    case @anchor
    when :top_left
      { x: parent.position.x, y: parent.position.y }
    when :bottom_left
      { x: parent.position.x,
        y: parent.position.y + parent.size.height - size.height }
    end
  end

  def resolve_array_size
    raise ArgumentError if @size.count > 2
    raise ArgumentError if @size.map(&:class).uniq.count != 1

    case @size.first
    when String
      x_ratio, y_ratio = resolve_percentage_array_size

      Size.new(height: parent.size.height * y_ratio, width: parent.size.width * x_ratio)
    when Integer
      Size.new(height: @size.first, width: @size.last)
    else
      # TODO: the following should be a custom
      raise ArgumentError, ERR__UNRECOG_SIZE_FORMAT
    end
  end

  def resolve_percentage_array_size
    @size.map { |value| (value.to_f / 100.0).round(2) }
  end
end
