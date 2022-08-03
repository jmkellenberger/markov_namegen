require "./lib/namegen"

names = ['Abarra', 'Guparta', 'Koyo Isu', 'Bozeg', 'Phodai', 'Teraat', 'Qabis',
  'Chakiragar', 'Tismin Insu', 'Kalmoro', 'Ethar', 'Kotelga', 'Altaxa', 'Nebay',
  'Nebayanat', 'Aamidal', 'Standing', 'Bhidra', 'Oret Soi', 'Sudarai', 'Bhojo Patal',
  'Matra Dhor',  'Niyat Dhor', 'Grahisa', 'Kono Manoi', 'Turagai', 'Jamosom', 'Ekanga',
  'Desh', 'Yaburah', 'Tsugge', 'Harai', 'Rumid', 'Siur', 'Ksu', 'Vo', 'Su', 'Kusaslu',
  'Bhanusri', 'Nasiraat', 'Santhe', 'Sestab','Kano Insu', 'Kusequ', 'Kanoyariya', 
  'Turaatrah', 'Guparahid', 'Joyen Bor']
gen = NameGen.new(names)

list = []

100000.times do
  list.push(gen.new_name)
end

describe NameGen do    
  describe "#new" do
    it "raises an error when first param is not an array" do
      expect {NameGen.new('Pachei')}.to raise_error('Invalid name data.')
    end

    it "raises an error when chainlength 0" do 
      expect {NameGen.new(names, 0)}.to raise_error('Chain length must be between 1 and 10.')
    end

    it "raises an error when chainlength > 10" do 
      expect {NameGen.new(names, rand(10..1000))}.to raise_error('Chain length must be between 1 and 10.')
    end

    it "accepts a array of names and an integer between 1-10 as params" do
      expect(NameGen.new(names, rand(1..10)).new_name.class).to eql(String)
    end
  end

  describe "#new_name" do
    it "generates a string" do
      expect(gen.new_name.class).to eql(String)
    end

    it "generates a string between 1 and 10 char in length" do
      expect(list.all? { |name| name.length.between?(1, 10) }).to eql(true)
    end

    it "generates a unique name by default" do
      expect(list.all? { |name| true unless names.include?(name) }).to eql(true)
    end

    it "sometimes outputs names from original data when unique:false" do
      list = []
      100000.times do
        list.push(gen.new_name(unique:false))
      end
      expect(list.any? { |name| names.include?(name) }).to eql(true)
    end
  end
end