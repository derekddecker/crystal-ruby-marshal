require "./spec_helper"

describe Ruby::Marshal do

  it "#dump true" do
		object = Ruby::Marshal.dump(true)
		puts object.hexdump
  end

  it "#dump false" do
		object = Ruby::Marshal.dump(false)
		puts object.hexdump
  end

end
