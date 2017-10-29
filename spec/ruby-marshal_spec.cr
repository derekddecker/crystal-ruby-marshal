require "./spec_helper"

describe Ruby::Marshal do

  pending "#load IO" do
		Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) ) 
  end

	it "should raise an exception on invalid version" do
		expect_raises(Ruby::Marshal::UnsupportedVersion) do
			Ruby::Marshal.load( File.open( "#{SPEC_ROOT}/data/marshalled-invalid-version.out" ) )
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
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-two-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::TwoBytePositiveInt)
		object.data.should eq(256)
	end

	it "should read a marshalled positive two byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-two-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::TwoBytePositiveInt)
		object.data.should eq(65_535)
	end

	it "should read a marshalled negative two byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-two-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::TwoByteNegativeInt)
		object.data.should eq(-65_536)
	end

	it "should read a marshalled negative two byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-two-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::TwoByteNegativeInt)
		object.data.should eq(-257)
	end


	it "should read a marshalled positive three byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-three-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::ThreeBytePositiveInt)
		object.data.should eq(65_536)
	end

	it "should read a marshalled positive three byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-three-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::ThreeBytePositiveInt)
		object.data.should eq(16_777_215)
	end

	it "should read a marshalled negative three byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-three-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::ThreeByteNegativeInt)
		object.data.should eq(-16_777_216)
	end

	it "should read a marshalled negative three byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-three-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::ThreeByteNegativeInt)
		object.data.should eq(-65_537)
	end


	it "should read a marshalled positive four byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-four-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::FourBytePositiveInt)
		object.data.should eq(16_777_216)
	end

	it "should read a marshalled positive four byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-positive-four-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::FourBytePositiveInt)
		object.data.should eq(1_073_741_823)
	end

	it "should read a marshalled negative four byte integer lower bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-four-byte-integer-lower.out" ) )
		object.should be_a(Ruby::Marshal::FourByteNegativeInt)
		object.data.should eq(-1_073_741_824)
	end

	it "should read a marshalled negative four byte integer upper bound" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-negative-four-byte-integer-upper.out" ) )
		object.should be_a(Ruby::Marshal::FourByteNegativeInt)
		object.data.should eq(-16_777_217)
	end

	it "should read a marshalled float" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-float.out" ) )
		object.should be_a(Ruby::Marshal::Float)
		object.data.should eq(-1.67320495432149)
	end

	it "should read a marshalled symbol" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-symbol.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-symbol.out" ) )
		object.should be_a(Ruby::Marshal::Symbol)
		object.data.should eq("test_symbol")
	end

	it "should read a marshalled symbol array" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-symbol-array.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-symbol-array.out" ) )
		object.should be_a(Ruby::Marshal::Array)
		object.data.should eq(["hello", "hello"])
	end

	it "should read a marshalled complex array" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-complex-array.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-complex-array.out" ) )
		object.should be_a(Ruby::Marshal::Array)
		object.data.should eq(["hello", "hello", ["hello", "test", 1, nil], 1_000_000, true, false, nil, "string", "string"])
	end

	it "should read a marshalled string" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-string.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-string.out" ) )
		object.should be_a(Ruby::Marshal::InstanceObject)
		object.data.should eq("test_string")
	end

	it "should read a marshalled object" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-valid.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) ).as(::Ruby::Marshal::Object)
		object.read_attr("id", true).should eq(1)
		object.read_attr("name", true).should eq("Test")
		object.read_attr("valid", true).should eq(true)
		data_hash = object.read_attr("data").as(Ruby::Marshal::Hash)
		data_hash["some"].data.should eq(true)
		data_hash[1].data.should eq("extra")
		data_hash.data.each do |(k, v)| 
			if(k.class == Ruby::Marshal::Hash)
				v.data.should eq(0x01)
			end
		end
	end

	it "should read a marshalled into a provided class" do
		user = Ruby::Marshal.load( User, File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) )
		user.id.should eq(1)
		user.name.should eq("Test")
		user.valid.should eq(true)
		user.data["some"].should eq(true)
		user.data[1].should eq("extra")
		user.data[{"key" => 1}].should eq(0x01)
	end

	it "should read a marshalled hash" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-hash.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-hash.out" ) )
		object.as(::Ruby::Marshal::Hash)["simple"].data.should eq("hash")
	end

	it "should read a marshalled hash with a default" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-hash-with-default.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-hash-with-default.out" ) ).as(Ruby::Marshal::Hash)
		object["key"].data.should eq(1)
		object.default_value.data.should eq("default_value")
		raw_hash = object.raw_hash
		raw_hash["new_key"].should eq("default_value")
	end

end
