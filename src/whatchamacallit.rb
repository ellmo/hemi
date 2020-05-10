# This is where +Whatchamacallit+ class overview is specified.
#
# We can use that place to remind ourselves of RDOC/YARD syntax.
#
# basic sytax::
#   _italic_
#
#   *bold*
#
#   +code+
#::
#   an internal link to {do_stuff}
#
#   or external http://lmgtfy.com
#
# Also
#   We can use
#   a code
#   block.
#
#== we can separate stuff like that
#
#
# lorem ipsum::
#   Well, the way they make shows is, they make one show. That show's called a pilot.
#   Then they show that show to the people who make shows, and on the strength of that one
#   show they decide if they're going to make more shows. Some pilots get picked and become
#   television programs. Some don't, become nothing. She starred in one of the ones that became
#   nothing.

class Whatchamacallit

  # This overrides default summary.
  def initialize; end

  # The first sentence is displayed twice, first time in Method Summary. This one is omitted.
  #
  # The rest is at the bottom of the screen.
  # This is the final line of this method's documentation.
  def do_stuff(param1, param2 = nil, param3: "asd")
    asd = <<~STR
      I am doing stuff.
      param1 is #{param1}
      param2 is #{param2}
      param3 is #{param3}
    STR

    puts asd
    nil
  end
end
