require_relative "lib/namegen"

names = ['Abarra', 'Guparta', 'Koyo Isu', 'Bozeg', 'Phodai', 'Teraat', 'Qabis',
  'Chakiragar', 'Tismin Insu', 'Kalmoro', 'Ethar', 'Kotelga', 'Altaxa', 'Nebay',
  'Nebayanat', 'Aamidal', 'Standing', 'Bhidra', 'Oret Soi', 'Sudarai', 'Bhojo Patal',
  'Matra Dhor',  'Niyat Dhor', 'Grahisa', 'Kono Manoi', 'Turagai', 'Jamosom', 'Ekanga',
  'Desh', 'Yaburah', 'Tsugge', 'Harai', 'Rumid', 'Siur', 'Ksu', 'Vo', 'Su', 'Kusaslu',
  'Bhanusri', 'Nasiraat', 'Santhe', 'Sestab','Kano Insu', 'Kusequ', 'Kanoyariya', 
  'Turaatrah', 'Guparahid', 'Joyen Bor']

markov = NameGen.new(names, 2)

25.times do
  puts markov.new_name(unique: true)
end