require "./spec_helper"

describe Ruby::Marshal do
  it "#load IO" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/marshalled_player.out" ) ) 
  end
end
