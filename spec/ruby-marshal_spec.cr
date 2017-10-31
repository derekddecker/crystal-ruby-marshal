require "./spec_helper"

describe Ruby::Marshal do

  it "#load IO" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) ).as(Ruby::Marshal::Object)
		object.read_attr("name", true).should eq("Test")
  end

	it "should raise an exception on invalid version" do
		expect_raises(Ruby::Marshal::UnsupportedVersion) do
			Ruby::Marshal.load( File.open( "#{SPEC_ROOT}/data/marshalled-invalid-version.out" ) )
		end
	end

	it "should raise an exception on invalid marshal data" do
		expect_raises(Ruby::Marshal::InvalidMarshalData) do
			Ruby::Marshal.load( File.open( "#{SPEC_ROOT}/data/marshalled-invalid-data.out" ) )
		end
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

	it "should read a marshalled float infinity" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-float-infinity.out" ) )
		object.should be_a(Ruby::Marshal::Float)
		object.data.should eq(Float64::INFINITY)
	end

	it "should read a marshalled float negative infinity" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-float-negative-infinity.out" ) )
		object.should be_a(Ruby::Marshal::Float)
		object.data.should eq(-Float64::INFINITY)
	end

	it "should read a marshalled float nan" do
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-float-nan.out" ) )
		object.should be_a(Ruby::Marshal::Float)
		object.data.as(::Float64).nan?.should eq(true)
	end

	it "should read a marshalled BigNum" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-bignum.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-bignum.out" ) )
		object.should be_a(Ruby::Marshal::BigNum)
		object.data.should be_a(::Bytes)
		object.stream_size.should eq(17)
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

	it "should read a marshalled object into a provided class" do
		user = Ruby::Marshal.load( User, File.read( "#{SPEC_ROOT}/data/marshalled-valid.out" ) )
		user.id.should eq(1)
		user.name.should eq("Test")
		user.valid.should eq(true)
		user.data["some"].should eq(true)
		user.data[1].should eq("extra")
		user.data[{"key" => 1}].should eq(0x01)
	end

	it "should read a marshalled object with modules" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-object-extended.out`
		user = Ruby::Marshal.load( ExtendedUser, File.read( "#{SPEC_ROOT}/data/marshalled-object-extended.out" ) )
		user.id.should eq(2)
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

	it "should read a marshalled class" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-class.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-class.out" ) )
		object.should be_a(Ruby::Marshal::Class)
		::String.new(object.data.as(::Bytes)).should eq("User")
	end

	it "should read a marshalled module" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-module.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-module.out" ) )
		object.should be_a(Ruby::Marshal::Module)
		::String.new(object.data.as(::Bytes)).should eq("TestModule")
	end

	it "should read a marshalled regex" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-regex.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-regex.out" ) )
		object.data.should be_a(::Regex)
		regex = object.data.as(::Regex)
		regex.match("ASDasd0045").should_not eq(nil)
		regex.match("'asdf'").should eq(nil)
	end

	it "should read a marshalled struct" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-struct.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-struct.out" ) )
		object.should be_a(::Ruby::Marshal::Struct)
	end

	it "should read a marshalled struct into a class" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-struct.out`
		object = Ruby::Marshal.load( Customer, File.read( "#{SPEC_ROOT}/data/marshalled-struct.out" ) )
		object.should be_a(::Customer)
		object.name.should eq("Dave")
		object.age.should eq(29)
		object.valid.should eq(false)
		object.address.should eq("123 Main")
	end

	it "should read a marshalled user class" do
		#puts `xxd #{SPEC_ROOT}/data/marshalled-user-class.out`
		object = Ruby::Marshal.load( File.read( "#{SPEC_ROOT}/data/marshalled-user-class.out" ) )
		object.should be_a(Ruby::Marshal::UserClass)
		object = object.as(Ruby::Marshal::UserClass)
		object.class_name.data.should eq("UserHash")
		object.data.should be_a(Ruby::Marshal::HashWithDefault)
		wrapped_object = object.data.as(Ruby::Marshal::HashWithDefault)
		wrapped_object["data"].data.should eq(123)
	end

end
