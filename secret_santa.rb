require 'pry'
class SecretSanta

  @participants_hash = {}

  def initialize
    families_array = create_array_from_file
    @participants_hash = create_hash_from_array(families_array)
  end

  def create_array_from_file
    families = []
    File.open('participants2.txt', 'r') do |f|
      f.each_line do |line|
        names = line.split(" ")
        families << names
      end
    end
    families
  end

  def create_hash_from_array(families_array)
    families_hash = families_array.each_with_object({}) do |family, people_and_fam_hash|
      family.each do |person|
        people_and_fam_hash[person] = {:family => family, :has_a_santa => false}
      end
    end
    Hash[families_hash.sort_by{|name, data| data[:family].length}.reverse]
  end

  def possible_partners(santa)
    santas = @participants_hash.keys
    possible_partners = santas.map do |a_santa|
      if santa != a_santa && @participants_hash[a_santa][:has_a_santa] == false && !(@participants_hash[santa][:family].include?(a_santa))
        a_santa
      end
    end.compact
  end

  def assign_secret_santa_partners
    santas = @participants_hash.keys
    santas.each_with_object({}) do |santa, secret_santa_pairs|
      santas_possible_partners = possible_partners(santa)
      partner = santas_possible_partners[rand(0..(santas_possible_partners.length - 1))]
      @participants_hash[partner][:has_a_santa] = true
      secret_santa_pairs[santa] = partner
    end
  end

end