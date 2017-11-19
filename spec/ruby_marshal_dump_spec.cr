require "./spec_helper"

describe Ruby::Marshal do

  it "#dump true" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-true.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(true) ) }
		object = Ruby::Marshal.dump(true)
		Ruby::Marshal.load( File.open(f) ).data.should be_true
  end

  it "#dump false" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-false.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(false) ) }
		object = Ruby::Marshal.dump(false)
		Ruby::Marshal.load( File.open(f) ).data.should be_false
  end

  it "#dump nil" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-nil.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(nil) ) }
		object = Ruby::Marshal.dump(nil)
		Ruby::Marshal.load( File.open(f) ).data.should be_nil
  end

  it "#dump a class" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-class.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(User) ) }
		object = Ruby::Marshal.dump(User)
		Ruby::Marshal.load( File.open(f) ).data.should eq("User")
  end

  it "#dump a module" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-module.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(TestModule) ) }
		object = Ruby::Marshal.dump(TestModule)
		Ruby::Marshal.load( File.open(f) ).data.should eq("TestModule")
  end

  it "#dump a symbol" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-symbol.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(:test_symbol) ) }
		object = Ruby::Marshal.dump(:test_symbol)
		Ruby::Marshal.load( File.open(f) ).data.should eq("test_symbol")
  end

  it "#dump 0" do
		f = File.join(File.dirname( __FILE__ ), "tmp", "marshalled-zero.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(0) ) }
		object = Ruby::Marshal.dump(0)
		Ruby::Marshal.load( File.open(f) ).data.should eq(0)
  end

  it "#dump 122" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-zero-byte-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(122) ) }
		object = Ruby::Marshal.dump(122)
		Ruby::Marshal.load( File.open(f) ).data.should eq(122)
  end

  it "#dump -122" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-zero-byte-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-122) ) }
		object = Ruby::Marshal.dump(-122)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-122)
  end

  it "#dump -123" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-one-byte-negative-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-123) ) }
		object = Ruby::Marshal.dump(-123)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-123)
  end

  it "#dump 123" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-one-byte-positive-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(123) ) }
		object = Ruby::Marshal.dump(123)
		Ruby::Marshal.load( File.open(f) ).data.should eq(123)
  end

  it "#dump 255" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-one-byte-positive-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(255) ) }
		object = Ruby::Marshal.dump(255)
		Ruby::Marshal.load( File.open(f) ).data.should eq(255)
  end

  it "#dump -256" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-one-byte-negative-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-256) ) }
		object = Ruby::Marshal.dump(-256)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-256)
  end

  it "#dump 256" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-two-byte-positive-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(256) ) }
		object = Ruby::Marshal.dump(256)
		Ruby::Marshal.load( File.open(f) ).data.should eq(256)
  end

  it "#dump -257" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-two-byte-negative-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-257) ) }
		object = Ruby::Marshal.dump(-257)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-257)
  end

  it "#dump 65_535" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-two-byte-positive-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(65_535) ) }
		object = Ruby::Marshal.dump(65_535)
		Ruby::Marshal.load( File.open(f) ).data.should eq(65_535)
  end

  it "#dump -65_536" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-two-byte-negative-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-65_536) ) }
		object = Ruby::Marshal.dump(-65_536)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-65_536)
  end

  it "#dump 65_536" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-three-byte-positive-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(65_536) ) }
		object = Ruby::Marshal.dump(65_536)
		Ruby::Marshal.load( File.open(f) ).data.should eq(65_536)
  end

  it "#dump 16_777_215" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-three-byte-positive-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(16_777_215) ) }
		object = Ruby::Marshal.dump(16_777_215)
		Ruby::Marshal.load( File.open(f) ).data.should eq(16_777_215)
  end

  it "#dump -65_537" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-three-byte-negative-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-65_537) ) }
		object = Ruby::Marshal.dump(-65_537)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-65_537)
  end

  it "#dump -16_777_216" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-three-byte-negative-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-16_777_216) ) }
		object = Ruby::Marshal.dump(-16_777_216)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-16_777_216)
  end

  it "#dump 16_777_216" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-four-byte-positive-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(16_777_216) ) }
		object = Ruby::Marshal.dump(16_777_216)
		Ruby::Marshal.load( File.open(f) ).data.should eq(16_777_216)
  end

  it "#dump 1_073_741_823" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-four-byte-positive-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(1_073_741_823) ) }
		object = Ruby::Marshal.dump(1_073_741_823)
		Ruby::Marshal.load( File.open(f) ).data.should eq(1_073_741_823)
  end

  it "#dump -16_777_217" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-four-byte-negative-int-upper.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-16_777_217) ) }
		object = Ruby::Marshal.dump(-16_777_217)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-16_777_217)
  end

  it "#dump -1_073_741_824" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-four-byte-negative-int-lower.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-1_073_741_824) ) }
		object = Ruby::Marshal.dump(-1_073_741_824)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-1_073_741_824)
  end

	it "#dump -1.26479" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-float.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(-1.26479) ) }
		object = Ruby::Marshal.dump(-1.26479)
		Ruby::Marshal.load( File.open(f) ).data.should eq(-1.26479)
  end

	it "#dump an array" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-array.out")
		a = ["string", 1, -1.2, nil, true, false, [true, nil, :symbol]]
		b = ["string", 1, -1.2, nil, true, false, [true, nil, "symbol"]]
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(a) ) }
		object = Ruby::Marshal.dump(a)
		Ruby::Marshal.load( File.open(f) ).data.should eq(b)
  end

	it "#dump a hash" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-hash.out")
		a = { "simple" => 1, :hash => -1.2 }
		b = { "simple" => 1, "hash" => -1.2 }
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(a) ) }
		object = Ruby::Marshal.dump(a)
		Ruby::Marshal.load( File.open(f) ).as(Ruby::Marshal::Hash).raw_hash.should eq(b)
  end

	it "#dump a hash with default value" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-hash-with-default.out")
		a = Hash(String, String | Int32).new("Default")
		a["simple"] = 1
		#puts a["nonexistent"]
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(a) ) }
		#puts `xxd #{f}`
		object = Ruby::Marshal.dump(a)
		r = Ruby::Marshal.load( File.open(f) ).as(Ruby::Marshal::HashWithDefault).raw_hash
		r.should eq(a)
		r["nada"].should eq("Default")
	end

	it "#dump an instance" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-instance-object.out")
		object = DumpTestUser.new
		object.id = 1
		object.name = "string name"
		object.valid = false
		object.opts = { "this" => "hash" }
		write = Ruby::Marshal.dump(object)
		File.open(f, "w") { |f| f.write(write) }
		puts write.inspect
		puts `xxd #{f}`
		#result = Ruby::Marshal.load( DumpTestUser, File.open(f) )
		#puts result.inspect
		#result.should eq(object)
  end

	# TODO - these should dump InstanceObjects
	it "#dump an regex" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-regex.out")
		a = /[A-Za-z0-9]+/
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump(a) ) }
		object = Ruby::Marshal.dump(a)
		result = Ruby::Marshal.load( File.open(f) )
		#puts result.inspect
		result.data.should eq(a)
  end

	it "#dump \"a string\"" do
		f =  File.join(File.dirname( __FILE__ ), "tmp", "marshalled-string.out")
		File.open(f, "w") { |f| f.write( Ruby::Marshal.dump("a string") ) }
		object = Ruby::Marshal.dump("a string")
		Ruby::Marshal.load( File.open(f) ).data.should eq("a string")
  end

end
