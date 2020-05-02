# @private
#
# This class has no auto-generated content. It's private and +.yardopts+
# is instructed to ignore +@private+
class Thingamabob
  attr_accessor :whatchamacallit

  def initialize
    @whatchamacallit = Whatchamacallit.new
  end

  def start
    whatchamacallit.do_stuff("qwe")
    nil
  end
end
