require_relative 'spec_helper'
require_relative '../secret_santa'

describe SecretSanta do 
  let(:santa) { SecretSanta.new }

  context '#create_hash_from_array' do
    it 'opens and creates a hash of people and their family members' do
      result = {"Jerry"=>{:family=>["Jeff", "Jerry"], :has_a_santa=>false}, "Jeff"=>{:family=>["Jeff", "Jerry"], :has_a_santa=>false}, "Johnson"=>{:family=>["Johnson"], :has_a_santa=>false}, "Joe"=>{:family=>["Joe"], :has_a_santa=>false}}
      family_array = santa.create_array_from_file
      expect(santa.create_hash_from_array(family_array)).to eq(result)
    end
  end

  context '#possible_partners' do
    it 'makes a list of all possible partners for a santa' do
      expect(santa.possible_partners("Jeff")).to include("Johnson", "Joe")
    end

  end

  context '#assign_secret_santa_partners' do 
    it 'returns a hash with each santa (key) and his partner (value)' do 
      partners = santa.assign_secret_santa_partners
      expect(partners).to be_a(Hash)
      santa2 = SecretSanta.new
      santa2_pairs = santa2.assign_secret_santa_partners
      expect(santa2_pairs.keys).to eq(["Jerry", "Jeff", "Johnson", "Joe"])
      expect(santa2_pairs.keys.length).to eq(4)
      expect(santa2_pairs.values).to_not eq(santa2_pairs.keys)
    end
  end

end