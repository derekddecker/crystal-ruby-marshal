require "./spec_helper"

describe Ruby::Marshal do

  pending "#load IO" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) ) 
  end

	it "should raise an exception on invalid version" do
		expect_raises(Ruby::Marshal::UnsupportedVersion) do
			Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-invalid-version.out" ) )
		end
	end

	pending "should raise an exception on invalid marshal data" do

	end

	it "should read a marshalled negative integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::OneByteInt)
		object.data.should eq(-1)
	end

	it "should read a marshalled negative integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::OneByteInt)
		object.data.should eq(-122)
	end
	
	it "should read a marshalled positive integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::OneByteInt)
		object.data.should eq(1)
	end
	
	it "should read a marshalled positive integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::OneByteInt)
		object.data.should eq(122)
	end


	it "should read a marshalled positive one byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-one-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::OneBytePositiveInt)
		object.data.should eq(123)
	end

	it "should read a marshalled positive one byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-one-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::OneBytePositiveInt)
		object.data.should eq(255)
	end

	it "should read a marshalled negative one byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-one-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::OneByteNegativeInt)
		object.data.should eq(-256)
	end

	it "should read a marshalled negative one byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-one-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::OneByteNegativeInt)
		object.data.should eq(-124)
	end


	it "should read a marshalled positive two byte integer lower bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-two-byte-integer-lower.out" ) ).data.should eq(256)
	end

	it "should read a marshalled positive two byte integer upper bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-two-byte-integer-upper.out" ) ).data.should eq(65535)
	end

	it "should read a marshalled negative two byte integer lower bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-two-byte-integer-lower.out" ) ).data.should eq(-32_768)
	end

	it "should read a marshalled negative two byte integer lower bound (wtf)" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-two-byte-integer-lower-wtf.out" ) ).data.should eq(-32_770)
	end

	it "should read a marshalled negative two byte integer upper bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-two-byte-integer-upper.out" ) ).data.should eq(-257)
	end


	it "should read a marshalled positive three byte integer lower bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-three-byte-integer-lower.out" ) ).data.should eq(65_536)
	end

	it "should read a marshalled positive three byte integer upper bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-three-byte-integer-upper.out" ) ).data.should eq(16_776_960)
	end

	it "should read a marshalled negative three byte integer lower bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-three-byte-integer-lower.out" ) ).data.should eq(-8_388_480)
	end

	it "should read a marshalled negative three byte integer upper bound" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-three-byte-integer-upper.out" ) ).data.should eq(-32_769)
	end

end
