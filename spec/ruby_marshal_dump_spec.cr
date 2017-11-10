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

end
