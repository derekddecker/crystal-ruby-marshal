require "./spec_helper"

describe Ruby::Marshal do

  it "#dump true" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-true.out"), "w") { |f| f.write( Ruby::Marshal.dump(true) ) }
		object = Ruby::Marshal.dump(true)
		puts object.hexdump
  end

  it "#dump false" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-false.out"), "w") { |f| f.write( Ruby::Marshal.dump(false) ) }
		object = Ruby::Marshal.dump(false)
		puts object.hexdump
  end

  it "#dump nil" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-nil.out"), "w") { |f| f.write( Ruby::Marshal.dump(nil) ) }
		object = Ruby::Marshal.dump(nil)
		puts object.hexdump
  end

  it "#dump a class" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-class.out"), "w") { |f| f.write( Ruby::Marshal.dump(User) ) }
		object = Ruby::Marshal.dump(User)
		puts object.hexdump
  end

  it "#dump a module" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-module.out"), "w") { |f| f.write( Ruby::Marshal.dump(TestModule) ) }
		object = Ruby::Marshal.dump(TestModule)
		puts object.hexdump
  end

  it "#dump a symbol" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-symbol.out"), "w") { |f| f.write( Ruby::Marshal.dump(:test_symbol) ) }
		object = Ruby::Marshal.dump(:test_symbol)
		puts object.hexdump
  end

  it "#dump 0" do
		File.open( File.join(File.dirname( __FILE__ ), "tmp", "marshalled-zero.out"), "w") { |f| f.write( Ruby::Marshal.dump(0) ) }
		object = Ruby::Marshal.dump(0)
		puts object.hexdump
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

end
