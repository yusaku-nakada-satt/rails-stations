require 'rails_helper'

RSpec.describe Ranking, type: :model do
  describe 'rankingmodel attribure: movie' do
  let(:movie) { create(:movie) }
  let(:ranking) { build(:ranking, movie_id: movie.id) }

  it 'movie_idがnilの時登録できないこと' do
    ranking.movie_id = nil
    expect(ranking).not_to be_valid
  end

  it 'reserved_countがnilの時登録できないこと' do
    ranking.reserved_count = nil
    expect(ranking).not_to be_valid
  end

  end
end
