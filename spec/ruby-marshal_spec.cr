require "./spec_helper"

describe Ruby::Marshal do

	it "#load IO" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) ) 
  end

	it "should raise an exception on invalid version" do
		expect_raises(Ruby::Marshal::UnsupportedVersion) do
			Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-invalid-version.out" ) )
		end
	end

	it "should raise an exception on invalid marshal data" do

	end

	it "should read a marshalled integer" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-integer.out" ) ).data.should eq(145)
	end

end
